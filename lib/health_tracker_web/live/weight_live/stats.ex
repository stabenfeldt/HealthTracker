defmodule HealthTrackerWeb.WeightLive.Stats do
  use HealthTrackerWeb, :live_view
  alias HealthTracker.DateUtils

  on_mount HealthTrackerWeb.UserLiveAuth

  def mount(_params, _session, socket) do
    # Labels goes on the X-graph.
    # This will be the last 4 weeks.
    labels = get_timeline()

    # Values goes on the Y-graph.
    # Enum.map(labels, fn _ -> get_timeline(:weeks) end)
    values = get_weight_values_for_user(current_user(socket))

    {:ok,
     assign(socket,
       chart_data: %{
         labels: labels,
         values: values
       }
     )}
  end

  # The last 4 weeks
  def get_timeline() do
    DateUtils.last_four_weeks_dates()
  end

  def render(assigns) do
    ~L"""
    <div id="stats">
      <h1>Stats</h1>
      <canvas id="health-stats"
              phx-hook="LineChart">
      </canvas>
    </div>
    """
  end
end
