defmodule HealthTrackerWeb.PageControllerTest do
  use HealthTracker.FeatureCase, async: true
  import Wallaby.Browser
  alias HealthTracker.Factory

  # Setup a user account once before running any tests
  setup_all do
    user = Factory.insert(:user)
    {:ok, %{user: user}}
  end
  defp sign_in(session, as: user) do
    IO.puts("Signing in as #{user.email}")
    IO.puts("Signing in with password #{user.password}")

    session
    |> visit("/")
    |> click(Query.link("Log in"))
    |> fill_in(Query.text_field("Email"), with: user.email)
    |> fill_in(Query.text_field("Password"), with: user.password)
    |> click(Query.button("Sign in"))
    |> take_screenshot(name: "sign_in")
    |> assert_has(Query.css(".current_user", text: user.email))
  end

  test "user can visit homepage", %{session: session} do
    session
    |> visit("/")
    |> assert_has(Query.css(".tracking-tighter", text: "Peace of mind"))
  end

  # Test a protected page
  test "GET /weights", %{session: session} do
    user = Factory.insert(:user)

    session
    |> sign_in(as: user)
    |> visit("/weights")
    |> assert_has(Query.css("h1", text: "Listing Weights"))
  end
end
