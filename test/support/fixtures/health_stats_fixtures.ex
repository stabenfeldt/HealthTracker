defmodule HealthTracker.HealthStatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HealthTracker.HealthStats` context.
  """
  alias HealthTracker.Factory

  @doc """
  Generate a weight.
  """
  def weight_fixture(attrs \\ %{}) do
    user = Factory.insert(:user)

    {:ok, weight} =
      attrs
      |> Enum.into(%{
        weight: 120.5,
        user_id: user.id
      })
      |> HealthTracker.HealthStats.create_weight()

    weight
  end
end
