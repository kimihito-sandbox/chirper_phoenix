defmodule ChirperPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :chirper_phoenix,
    adapter: Ecto.Adapters.SQLite3
end
