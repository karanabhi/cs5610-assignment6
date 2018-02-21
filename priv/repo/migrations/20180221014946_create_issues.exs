defmodule Tracker.Repo.Migrations.CreateIssues do
  use Ecto.Migration

  def change do
    create table(:issues) do
      add :title, :string
      add :description, :text
      add :status, :string
      add :assigned_time, :integer
      add :user_id, references(:users, on_delete: :nothing)
      add :assigned_to_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:issues, [:user_id])
    create index(:issues, [:assigned_to])
  end
end
