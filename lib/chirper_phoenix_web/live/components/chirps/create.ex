defmodule ChirperPhoenixWeb.Components.Chirps.Create do
  use Phoenix.LiveView
  import ChirperPhoenixWeb.CoreComponents

  def render(assigns) do
    ~H"""
    <.simple_form for={@form}>
      <.input type="textarea" field={@form[:message]} class="block w-full border-gray-300 focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 rounded-md shadow-sm" placeholder="What's on your mind?"/>
      <:actions>
        <.button phx-disable-with="Saving..." type="submit" class="inline-flex items-center px-4 py-2 bg-gray-800 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-gray-700 focus:bg-gray-700 active:bg-gray-900 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 transition ease-in-out duration-150">Chirp</.button>
      </:actions>
    </.simple_form>
    """
  end



  def mount(_params, _session, socket) do
    temperature = 70 # Let's assume a fixed temperature for now
    message_form = to_form(%{"message" => ""})
    {:ok, socket |> assign(:temperature, temperature) |> assign(:form, message_form)}
  end

end
