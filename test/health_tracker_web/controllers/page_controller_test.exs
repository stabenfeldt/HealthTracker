defmodule HealthTrackerWeb.PageControllerTest do
  use HealthTracker.FeatureCase, async: true

  test "user can visit homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(Query.css(".tracking-tighter", text: "Peace of mind"))
  end
end
