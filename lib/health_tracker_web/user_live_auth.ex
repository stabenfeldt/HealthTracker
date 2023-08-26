defmodule HealthTrackerWeb.UserLiveAuth do
  import Phoenix.Component
  import Phoenix.LiveView
  alias HealthTracker.Accounts

  def on_mount(:on_mount, _params, %{"user_token" => user_token} = _session, socket) do
    IO.puts("\n\n\n ITS RUNNING on MOUNT \n\n\n")

    socket =
      assign_new(socket, :current_user, fn ->
        Accounts.get_user_by_session_token(user_token)
      end)

    IO.inspect(socket)

    {:cont, socket}
  end

  def on_mount(:default, _params, %{"user_token" => user_token} = _session, socket) do
    IO.puts("\n\n\n ITS RUNNING \n\n\n")

    socket =
      assign_new(socket, :current_user, fn ->
        Accounts.get_user_by_session_token(user_token)
      end)

    IO.puts("UserLiveAuth.on_mount/4: socket:")
    IO.inspect(socket)

    {:cont, socket}
  end
end
