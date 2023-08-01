defmodule HealthTracker.HealthStatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HealthTracker.HealthStats` context.
  """

  @doc """
  Generate a weight.
  """
  def weight_fixture(attrs \\ %{}) do
    {:ok, weight} =
      attrs
      |> Enum.into(%{
        weight: 120.5
      })
      |> HealthTracker.HealthStats.create_weight()

    weight
  end
end
