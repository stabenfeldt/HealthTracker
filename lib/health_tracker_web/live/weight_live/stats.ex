defmodule HealthTrackerWeb.WeightLive.Stats do
  use HealthTrackerWeb, :live_view

  on_mount HealthTrackerWeb.UserLiveAuth

  def mount(_params, _session, socket) do
    {:ok, socket}
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
