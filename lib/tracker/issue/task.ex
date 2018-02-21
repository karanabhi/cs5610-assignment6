defmodule Tracker.Issue.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Issue.Task


  schema "tasks" do
    field :assignedTime, :integer
    field :assigned_to, :integer
    field :description, :string
    field :status, :string, default: 'In Progress'
    field :title, :string, null: false
    field :user_id, :id, null: false

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :assigned_to, :status, :assignedTime])
    |> validate_required([:title, :description, :assigned_to, :status, :assignedTime])
  end
end
