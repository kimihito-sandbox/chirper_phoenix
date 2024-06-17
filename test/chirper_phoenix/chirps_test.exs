defmodule ChirperPhoenix.ChirpsTest do
  use ChirperPhoenix.DataCase

  alias ChirperPhoenix.Chirps

  describe "chirps" do
    alias ChirperPhoenix.Chirps.Chirp

    import ChirperPhoenix.ChirpsFixtures

    @invalid_attrs %{}

    test "list_chirps/0 returns all chirps" do
      chirp = chirp_fixture()
      assert Chirps.list_chirps() == [chirp]
    end

    test "get_chirp!/1 returns the chirp with given id" do
      chirp = chirp_fixture()
      assert Chirps.get_chirp!(chirp.id) == chirp
    end

    test "create_chirp/1 with valid data creates a chirp" do
      valid_attrs = %{}

      assert {:ok, %Chirp{} = chirp} = Chirps.create_chirp(valid_attrs)
    end

    test "create_chirp/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chirps.create_chirp(@invalid_attrs)
    end

    test "update_chirp/2 with valid data updates the chirp" do
      chirp = chirp_fixture()
      update_attrs = %{}

      assert {:ok, %Chirp{} = chirp} = Chirps.update_chirp(chirp, update_attrs)
    end

    test "update_chirp/2 with invalid data returns error changeset" do
      chirp = chirp_fixture()
      assert {:error, %Ecto.Changeset{}} = Chirps.update_chirp(chirp, @invalid_attrs)
      assert chirp == Chirps.get_chirp!(chirp.id)
    end

    test "delete_chirp/1 deletes the chirp" do
      chirp = chirp_fixture()
      assert {:ok, %Chirp{}} = Chirps.delete_chirp(chirp)
      assert_raise Ecto.NoResultsError, fn -> Chirps.get_chirp!(chirp.id) end
    end

    test "change_chirp/1 returns a chirp changeset" do
      chirp = chirp_fixture()
      assert %Ecto.Changeset{} = Chirps.change_chirp(chirp)
    end
  end
end
