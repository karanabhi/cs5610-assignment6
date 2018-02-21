defmodule Tracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :text
      add :status, :string
      add :assignedTime, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :assigned_to_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:user_id])
    create index(:tasks, [:assigned_to])
  end
end
