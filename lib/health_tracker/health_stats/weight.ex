defmodule HealthTracker.HealthStats.Weight do
  use Ecto.Schema
  import Ecto.Changeset

  schema "weights" do
    field :weight, :float
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(weight, attrs) do
    weight
    |> cast(attrs, [:weight])
    |> validate_required([:weight])
  end
end
