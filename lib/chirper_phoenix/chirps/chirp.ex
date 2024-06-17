defmodule ChirperPhoenix.Chirps.Chirp do
  use Ecto.Schema
  import Ecto.Changeset

  schema "chirps" do


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(chirp, attrs) do
    chirp
    |> cast(attrs, [])
    |> validate_required([])
  end
end
