defmodule TrackerWeb.TaskController do
  use TrackerWeb, :controller

  alias Tracker.Issue
  alias Tracker.Issue.Task

  def landing(conn, _params) do
    changeset = Issue.change_task(%Task{})
    render(conn, "landing.html", changeset: changeset)
  end

  def index(conn, _params) do
    tasks = Issue.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Issue.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"title" => title,"description" => description,"assignedTime" => assignedTime,
  "assigned_to"=>assigned_to,"status"=>status,"user_id"=>user_id}) do

    task_params=%{
      "title": title,
      "description": description,
      "assignedTime": assignedTime,
      "assigned_to": assigned_to,
      "status": status,
      "user_id": user_id
    }

    case Issue.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
        {:error, %Ecto.Changeset{} = changeset} ->
          render(conn, "new.html", changeset: changeset)
        end
      end

      #def create(conn, %{"task" => task_params}) do
      #  case Issue.create_task(task_params) do
      #    {:ok, task} ->
      #      conn
      #      |> put_flash(:info, "Task created successfully.")
      #      |> redirect(to: task_path(conn, :show, task))
      #      {:error, %Ecto.Changeset{} = changeset} ->
      #        render(conn, "new.html", changeset: changeset)
      #      end
      #    end

      def show(conn, %{"id" => id}) do
        task = Issue.get_task!(id)
        render(conn, "show.html", task: task)
      end

      def edit(conn, %{"id" => id}) do
        task = Issue.get_task!(id)
        changeset = Issue.change_task(task)
        render(conn, "edit.html", task: task, changeset: changeset)
      end

      def update(conn, %{"id" => id, "task" => task_params}) do
        task = Issue.get_task!(id)

        case Issue.update_task(task, task_params) do
          {:ok, task} ->
            conn
            |> put_flash(:info, "Task updated successfully.")
            |> redirect(to: task_path(conn, :show, task))
            {:error, %Ecto.Changeset{} = changeset} ->
              render(conn, "edit.html", task: task, changeset: changeset)
            end
          end

          def delete(conn, %{"id" => id}) do
            task = Issue.get_task!(id)
            {:ok, _task} = Issue.delete_task(task)

            conn
            |> put_flash(:info, "Task deleted successfully.")
            |> redirect(to: task_path(conn, :index))
          end
        end
