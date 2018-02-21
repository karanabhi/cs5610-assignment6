defmodule Tracker.Issuethread.Issue do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tracker.Issuethread.Issue


  schema "issues" do
    field :assigned_time, :integer
    field :description, :string
    field :status, :string
    field :title, :string
    field :user_id, :id
    field :assigned_to, :id

    timestamps()
  end

  @doc false
  def changeset(%Issue{} = issue, attrs) do
    issue
    |> cast(attrs, [:title, :description, :status, :assigned_time])
    |> validate_required([:title, :description, :status, :assigned_time])
  end
end
