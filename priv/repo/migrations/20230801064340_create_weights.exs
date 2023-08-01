defmodule HealthTracker.Repo.Migrations.CreateWeights do
  use Ecto.Migration

  def change do
    create table(:weights) do
      add :weight, :float
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:weights, [:user_id])
  end
end
