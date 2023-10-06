defmodule HealthTrackerWeb.WeightLive.Show do
  use HealthTrackerWeb, :live_view

  alias HealthTracker.HealthStats
  on_mount HealthTrackerWeb.UserLiveAuth

  @impl true
  def mount(_params, _session, socket) do
    if socket.assigns.live_action == :show do
      {:ok, assign(socket, date: Date.utc_today())}
    else
      {:ok, socket}
    end
    todays_date = Date.to_iso8601(Date.utc_today())

    # Assign today's date to the socket
    {:ok, assign(socket, todays_date: todays_date)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:weight, HealthStats.get_weight!(id))}
  end

  defp page_title(:show), do: "Show Weight"
  defp page_title(:edit), do: "Edit Weight"
end
