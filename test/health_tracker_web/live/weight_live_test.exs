defmodule HealthTrackerWeb.WeightLiveTest do
  use HealthTrackerWeb.ConnCase

  import Phoenix.LiveViewTest
  import HealthTracker.HealthStatsFixtures

  @create_attrs %{weight: 120.5}
  @update_attrs %{weight: 456.7}
  @invalid_attrs %{weight: nil}

  defp create_weight(_) do
    weight = weight_fixture()
    %{weight: weight}
  end

  describe "Index" do
    setup [:create_weight]

    test "lists all weights", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/weights")

      assert html =~ "Listing Weights"
    end

    test "saves new weight", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/weights")

      assert index_live |> element("a", "New Weight") |> render_click() =~
               "New Weight"

      assert_patch(index_live, ~p"/weights/new")

      assert index_live
             |> form("#weight-form", weight: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#weight-form", weight: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/weights")

      html = render(index_live)
      assert html =~ "Weight created successfully"
    end

    test "updates weight in listing", %{conn: conn, weight: weight} do
      {:ok, index_live, _html} = live(conn, ~p"/weights")

      assert index_live |> element("#weights-#{weight.id} a", "Edit") |> render_click() =~
               "Edit Weight"

      assert_patch(index_live, ~p"/weights/#{weight}/edit")

      assert index_live
             |> form("#weight-form", weight: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#weight-form", weight: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/weights")

      html = render(index_live)
      assert html =~ "Weight updated successfully"
    end

    test "deletes weight in listing", %{conn: conn, weight: weight} do
      {:ok, index_live, _html} = live(conn, ~p"/weights")

      assert index_live |> element("#weights-#{weight.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#weights-#{weight.id}")
    end
  end

  describe "Show" do
    setup [:create_weight]

    test "displays weight", %{conn: conn, weight: weight} do
      {:ok, _show_live, html} = live(conn, ~p"/weights/#{weight}")

      assert html =~ "Show Weight"
    end

    test "updates weight within modal", %{conn: conn, weight: weight} do
      {:ok, show_live, _html} = live(conn, ~p"/weights/#{weight}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Weight"

      assert_patch(show_live, ~p"/weights/#{weight}/show/edit")

      assert show_live
             |> form("#weight-form", weight: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#weight-form", weight: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/weights/#{weight}")

      html = render(show_live)
      assert html =~ "Weight updated successfully"
    end
  end
end
