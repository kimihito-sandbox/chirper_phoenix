defmodule ChirperPhoenixWeb.ChirpLive.Show do
  use ChirperPhoenixWeb, :live_view

  alias ChirperPhoenix.Chirps

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:chirp, Chirps.get_chirp!(id))}
  end

  defp page_title(:show), do: "Show Chirp"
  defp page_title(:edit), do: "Edit Chirp"
end
