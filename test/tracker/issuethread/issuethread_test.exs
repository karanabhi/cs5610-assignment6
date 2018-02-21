defmodule Tracker.IssuethreadTest do
  use Tracker.DataCase

  alias Tracker.Issuethread

  describe "issues" do
    alias Tracker.Issuethread.Issue

    @valid_attrs %{assigned_time: 42, description: "some description", status: "some status", title: "some title"}
    @update_attrs %{assigned_time: 43, description: "some updated description", status: "some updated status", title: "some updated title"}
    @invalid_attrs %{assigned_time: nil, description: nil, status: nil, title: nil}

    def issue_fixture(attrs \\ %{}) do
      {:ok, issue} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Issuethread.create_issue()

      issue
    end

    test "list_issues/0 returns all issues" do
      issue = issue_fixture()
      assert Issuethread.list_issues() == [issue]
    end

    test "get_issue!/1 returns the issue with given id" do
      issue = issue_fixture()
      assert Issuethread.get_issue!(issue.id) == issue
    end

    test "create_issue/1 with valid data creates a issue" do
      assert {:ok, %Issue{} = issue} = Issuethread.create_issue(@valid_attrs)
      assert issue.assigned_time == 42
      assert issue.description == "some description"
      assert issue.status == "some status"
      assert issue.title == "some title"
    end

    test "create_issue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Issuethread.create_issue(@invalid_attrs)
    end

    test "update_issue/2 with valid data updates the issue" do
      issue = issue_fixture()
      assert {:ok, issue} = Issuethread.update_issue(issue, @update_attrs)
      assert %Issue{} = issue
      assert issue.assigned_time == 43
      assert issue.description == "some updated description"
      assert issue.status == "some updated status"
      assert issue.title == "some updated title"
    end

    test "update_issue/2 with invalid data returns error changeset" do
      issue = issue_fixture()
      assert {:error, %Ecto.Changeset{}} = Issuethread.update_issue(issue, @invalid_attrs)
      assert issue == Issuethread.get_issue!(issue.id)
    end

    test "delete_issue/1 deletes the issue" do
      issue = issue_fixture()
      assert {:ok, %Issue{}} = Issuethread.delete_issue(issue)
      assert_raise Ecto.NoResultsError, fn -> Issuethread.get_issue!(issue.id) end
    end

    test "change_issue/1 returns a issue changeset" do
      issue = issue_fixture()
      assert %Ecto.Changeset{} = Issuethread.change_issue(issue)
    end
  end
end
