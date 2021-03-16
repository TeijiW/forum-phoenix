defmodule ForumWeb.ThreadController do
  use ForumWeb, :controller
  alias Forum.{Thread, Comment, Repo}

  def new(conn, _params) do
    changeset = Thread.changeset(%Thread{}, %{})

    conn
    |> render("new.html",
      changeset: changeset
    )
  end

  def index(conn, _params) do
    threads = Forum.get_threads(:with_comments_count)
    render(conn, "index.html", threads: threads)
  end

  def create(conn, %{"thread" => thread}) do
    case Forum.create_thread(thread) do
      {:error, changeset} -> render(conn, "new.html", changeset: changeset)
      {:ok, _thread} -> redirect_flash_index(conn, "Thread created")
    end
  end

  def show(conn, %{"id" => thread_id}) do
    changeset = Comment.changeset(%{})

    case Forum.fetch_thread(thread_id) do
      {:ok, thread} ->
        render(conn, "show.html",
          thread: Repo.preload(thread, :comments),
          changeset: changeset,
          thread_id: thread.id,
          show_thread_list_button: true
        )

      {:error, message} ->
        redirect_flash_index(conn, message, :error)
    end
  end

  def delete(conn, %{"id" => thread_id}) do
    case Forum.delete_thread(thread_id) do
      {:ok, _thread} -> redirect_flash_index(conn, "The thread has been deleted")
      {:error, message} -> redirect_flash_index(conn, message, :error)
    end
  end

  defp redirect_flash_index(conn, message, flash_type \\ :info, path \\ :index),
    do: conn |> put_flash(flash_type, message) |> redirect(to: Routes.thread_path(conn, path))
end
