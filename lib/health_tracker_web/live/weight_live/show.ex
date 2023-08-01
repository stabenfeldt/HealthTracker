defmodule HealthTrackerWeb.WeightLive.Show do
  use HealthTrackerWeb, :live_view

  alias HealthTracker.HealthStats

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
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
