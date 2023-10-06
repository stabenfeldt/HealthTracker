defmodule HealthTracker.Repo.Migrations.AddDateToWeights do
  use Ecto.Migration

  def change do
    alter table(:weights) do
      add :date, :date
    end
  end
end
