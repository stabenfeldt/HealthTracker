defmodule HealthTrackerWeb.WeightLive.FormComponent do
  use HealthTrackerWeb, :live_component

  alias HealthTracker.HealthStats
  alias HealthTracker.HealthStats.Weight
  on_mount HealthTrackerWeb.UserLiveAuth
  alias HealthTracker.Converter

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage weight records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="weight-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:weight]} type="number" label="Weight" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Weight</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{weight: weight} = assigns, socket) do
    changeset = HealthStats.change_weight(weight)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"weight" => weight_params}, socket) do
    changeset =
      socket.assigns.weight
      |> HealthStats.change_weight(weight_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"weight" => weight_params}, socket) do
    current_user_id = socket.assigns.current_user.id
    weight = weight_params["weight"]
    weight = Converter.to_float(weight)

    weight_params_with_user_id = %{weight: weight, user_id: current_user_id}
    save_weight(socket, socket.assigns.action, weight_params_with_user_id)
  end

  defp save_weight(socket, :edit, weight_params_with_user_id) do
    case HealthStats.update_weight(
           socket.assigns.weight,
           weight_params_with_user_id
         ) do
      {:ok, weight} ->
        notify_parent({:saved, weight})

        {:noreply,
         socket
         |> put_flash(:info, "Weight updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_weight(socket, :new, weight_params_with_user_id) do
    changeset = HealthStats.create_weight(weight_params_with_user_id)

    case changeset do
      {:ok, weight} ->
        notify_parent({:saved, weight})

        {:noreply,
         socket
         |> put_flash(:info, "Weight created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
