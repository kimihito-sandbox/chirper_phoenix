defmodule ChirperPhoenix.ChirpsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChirperPhoenix.Chirps` context.
  """

  @doc """
  Generate a chirp.
  """
  def chirp_fixture(attrs \\ %{}) do
    {:ok, chirp} =
      attrs
      |> Enum.into(%{

      })
      |> ChirperPhoenix.Chirps.create_chirp()

    chirp
  end
end
