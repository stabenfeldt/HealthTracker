defmodule HealthTracker.HealthStats.Weight do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias HealthTracker.Repo

  schema "weights" do
    field :weight, :float
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(weight, attrs) do
    weight
    |> cast(attrs, [:weight, :user_id])
    |> validate_required([:weight, :user_id])
  end

  def get_weight_values_for_user(user_id) do
    last_four_weeks_entries(user_id)
  end

  def last_four_weeks_entries(user_id) when is_integer(user_id) do
    IO.inspect(user_id, label: "user_id")
    # Calculate the date 4 weeks ago from today
    four_weeks_ago =
      DateTime.utc_now()
      |> DateTime.truncate(:second)
      |> DateTime.add(-28 * 24 * 60 * 60, :second)

    from(w in "weights",
      where: w.user_id == ^user_id,
      where: w.inserted_at >= ^four_weeks_ago,
      order_by: [desc: w.inserted_at],
      select: w.weight
    )
    |> Repo.all()
  end
end
