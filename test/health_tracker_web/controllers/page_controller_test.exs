defmodule HealthTrackerWeb.PageControllerTest do
  use HealthTracker.FeatureCase, async: true
  import Wallaby.Browser
  alias HealthTracker.Factory

  defp sign_in(session, as: user) do
    session
    |> visit("/")
    |> click(Query.link("Log in"))
    |> fill_in(Query.text_field("Email"), with: user.email)
    |> fill_in(Query.text_field("Password"), with: user.password)
    |> click(Query.button("Sign in"))
    |> take_screenshot(name: "sign_in")
    |> assert_has(Query.css(".current_user", text: "user@example.com"))
  end

  test "user can visit homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(Query.css(".tracking-tighter", text: "Peace of mind"))
  end

  # Test a protected page
  test "GET /weights", %{session: session} do
    user = Factory.insert(:user, email: "user@example.com")

    session
    |> sign_in(as: user)
    |> visit("/weights")
    |> assert_has(Query.css("h1", text: "Listing Weights"))
  end
end
