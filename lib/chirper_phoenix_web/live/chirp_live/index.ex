defmodule ChirperPhoenixWeb.ChirpLive.Index do
  use ChirperPhoenixWeb, :live_view

  alias ChirperPhoenix.Chirps
  alias ChirperPhoenix.Chirps.Chirp

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :chirps, Chirps.list_chirps())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Chirp")
    |> assign(:chirp, Chirps.get_chirp!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Chirp")
    |> assign(:chirp, %Chirp{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Chirps")
    |> assign(:chirp, nil)
  end

  @impl true
  def handle_info({ChirperPhoenixWeb.ChirpLive.FormComponent, {:saved, chirp}}, socket) do
    {:noreply, stream_insert(socket, :chirps, chirp)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    chirp = Chirps.get_chirp!(id)
    {:ok, _} = Chirps.delete_chirp(chirp)

    {:noreply, stream_delete(socket, :chirps, chirp)}
  end
end
