defmodule HealthTracker.HealthStats.Weight do
  use Ecto.Schema
  import Ecto.Changeset

  schema "weights" do
    field :weight, :float
    field :user_id, :id
    # TODO: Add date field

    timestamps()
  end

  @doc false
  def changeset(weight, attrs) do
    weight
    |> cast(attrs, [:weight, :user_id])
    |> validate_required([:weight, :user_id])
  end
end
