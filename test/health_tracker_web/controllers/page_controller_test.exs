defmodule HealthTrackerWeb.PageControllerTest do
  use HealthTracker.FeatureCase
  import Wallaby.Browser
  alias HealthTracker.Factory

  defp create_user() do
    Factory.insert(:user)
  end

  defp sign_in(session, as: user) do
    IO.inspect(user)
    IO.puts("Signing in as #{user.email}")
    IO.puts("Signing in with password #{user.password}")

    session
    |> visit("/")
    |> click(Query.link("Log in"))
    |> fill_in(Query.text_field("Email"), with: user.email)
    |> fill_in(Query.text_field("Password"), with: user.password)
    |> click(Query.button("Sign in"))
    |> take_screenshot(name: "sign_in")
    |> has_text?("Welcome back!")

    session
  end

  test "user can visit homepage", %{session: session} do
    session
    |> visit("/")
  end

  # Test a protected page
  test "GET /weights", %{session: session} do
    user = create_user()

    session
    |> sign_in(as: user)
    |> visit("/weights")
    |> assert_has(Query.css("h1", text: "Listing Weights"))
  end
end
