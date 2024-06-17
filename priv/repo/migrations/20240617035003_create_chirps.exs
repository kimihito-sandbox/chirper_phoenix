defmodule ChirperPhoenix.Repo.Migrations.CreateChirps do
  use Ecto.Migration

  def change do
    create table(:chirps) do

      timestamps(type: :utc_datetime)
    end
  end
end
