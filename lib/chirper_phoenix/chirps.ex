defmodule ChirperPhoenix.Chirps do
  @moduledoc """
  The Chirps context.
  """

  import Ecto.Query, warn: false
  alias ChirperPhoenix.Repo

  alias ChirperPhoenix.Chirps.Chirp

  @doc """
  Returns the list of chirps.

  ## Examples

      iex> list_chirps()
      [%Chirp{}, ...]

  """
  def list_chirps do
    Repo.all(Chirp)
  end

  @doc """
  Gets a single chirp.

  Raises `Ecto.NoResultsError` if the Chirp does not exist.

  ## Examples

      iex> get_chirp!(123)
      %Chirp{}

      iex> get_chirp!(456)
      ** (Ecto.NoResultsError)

  """
  def get_chirp!(id), do: Repo.get!(Chirp, id)

  @doc """
  Creates a chirp.

  ## Examples

      iex> create_chirp(%{field: value})
      {:ok, %Chirp{}}

      iex> create_chirp(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_chirp(attrs \\ %{}) do
    %Chirp{}
    |> Chirp.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a chirp.

  ## Examples

      iex> update_chirp(chirp, %{field: new_value})
      {:ok, %Chirp{}}

      iex> update_chirp(chirp, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_chirp(%Chirp{} = chirp, attrs) do
    chirp
    |> Chirp.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a chirp.

  ## Examples

      iex> delete_chirp(chirp)
      {:ok, %Chirp{}}

      iex> delete_chirp(chirp)
      {:error, %Ecto.Changeset{}}

  """
  def delete_chirp(%Chirp{} = chirp) do
    Repo.delete(chirp)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking chirp changes.

  ## Examples

      iex> change_chirp(chirp)
      %Ecto.Changeset{data: %Chirp{}}

  """
  def change_chirp(%Chirp{} = chirp, attrs \\ %{}) do
    Chirp.changeset(chirp, attrs)
  end
end
