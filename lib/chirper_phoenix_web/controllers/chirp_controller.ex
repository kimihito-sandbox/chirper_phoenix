
defmodule ChirperPhoenixWeb.ChirpController do
  use ChirperPhoenixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", chirps: [])
  end
end
