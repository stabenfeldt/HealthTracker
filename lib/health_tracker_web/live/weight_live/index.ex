defmodule HealthTrackerWeb.WeightLive.Index do
  use HealthTrackerWeb, :live_view

  alias HealthTracker.HealthStats
  alias HealthTracker.HealthStats.Weight

  on_mount HealthTrackerWeb.UserLiveAuth

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :weights, HealthStats.list_weights())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Weight")
    |> assign(:weight, HealthStats.get_weight!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Weight")
    |> assign(:weight, %Weight{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Weights")
    |> assign(:weight, nil)
  end

  @impl true
  def handle_info({HealthTrackerWeb.WeightLive.FormComponent, {:saved, weight}}, socket) do
    {:noreply, stream_insert(socket, :weights, weight)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    weight = HealthStats.get_weight!(id)
    {:ok, _} = HealthStats.delete_weight(weight)

    {:noreply, stream_delete(socket, :weights, weight)}
  end
end
