defmodule ChirperPhoenixWeb.ChirpLive.FormComponent do
  use ChirperPhoenixWeb, :live_component

  alias ChirperPhoenix.Chirps

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage chirp records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="chirp-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >

        <:actions>
          <.button phx-disable-with="Saving...">Save Chirp</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{chirp: chirp} = assigns, socket) do
    changeset = Chirps.change_chirp(chirp)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"chirp" => chirp_params}, socket) do
    changeset =
      socket.assigns.chirp
      |> Chirps.change_chirp(chirp_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"chirp" => chirp_params}, socket) do
    save_chirp(socket, socket.assigns.action, chirp_params)
  end

  defp save_chirp(socket, :edit, chirp_params) do
    case Chirps.update_chirp(socket.assigns.chirp, chirp_params) do
      {:ok, chirp} ->
        notify_parent({:saved, chirp})

        {:noreply,
         socket
         |> put_flash(:info, "Chirp updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_chirp(socket, :new, chirp_params) do
    case Chirps.create_chirp(chirp_params) do
      {:ok, chirp} ->
        notify_parent({:saved, chirp})

        {:noreply,
         socket
         |> put_flash(:info, "Chirp created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
