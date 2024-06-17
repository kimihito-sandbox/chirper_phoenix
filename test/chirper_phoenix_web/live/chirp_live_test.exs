defmodule ChirperPhoenixWeb.ChirpLiveTest do
  use ChirperPhoenixWeb.ConnCase

  import Phoenix.LiveViewTest
  import ChirperPhoenix.ChirpsFixtures

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp create_chirp(_) do
    chirp = chirp_fixture()
    %{chirp: chirp}
  end

  describe "Index" do
    setup [:create_chirp]

    test "lists all chirps", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/chirps")

      assert html =~ "Listing Chirps"
    end

    test "saves new chirp", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/chirps")

      assert index_live |> element("a", "New Chirp") |> render_click() =~
               "New Chirp"

      assert_patch(index_live, ~p"/chirps/new")

      assert index_live
             |> form("#chirp-form", chirp: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#chirp-form", chirp: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/chirps")

      html = render(index_live)
      assert html =~ "Chirp created successfully"
    end

    test "updates chirp in listing", %{conn: conn, chirp: chirp} do
      {:ok, index_live, _html} = live(conn, ~p"/chirps")

      assert index_live |> element("#chirps-#{chirp.id} a", "Edit") |> render_click() =~
               "Edit Chirp"

      assert_patch(index_live, ~p"/chirps/#{chirp}/edit")

      assert index_live
             |> form("#chirp-form", chirp: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#chirp-form", chirp: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/chirps")

      html = render(index_live)
      assert html =~ "Chirp updated successfully"
    end

    test "deletes chirp in listing", %{conn: conn, chirp: chirp} do
      {:ok, index_live, _html} = live(conn, ~p"/chirps")

      assert index_live |> element("#chirps-#{chirp.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#chirps-#{chirp.id}")
    end
  end

  describe "Show" do
    setup [:create_chirp]

    test "displays chirp", %{conn: conn, chirp: chirp} do
      {:ok, _show_live, html} = live(conn, ~p"/chirps/#{chirp}")

      assert html =~ "Show Chirp"
    end

    test "updates chirp within modal", %{conn: conn, chirp: chirp} do
      {:ok, show_live, _html} = live(conn, ~p"/chirps/#{chirp}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Chirp"

      assert_patch(show_live, ~p"/chirps/#{chirp}/show/edit")

      assert show_live
             |> form("#chirp-form", chirp: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#chirp-form", chirp: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/chirps/#{chirp}")

      html = render(show_live)
      assert html =~ "Chirp updated successfully"
    end
  end
end
