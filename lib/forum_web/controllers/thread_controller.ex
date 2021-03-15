defmodule ForumWeb.ThreadController do
  use ForumWeb, :controller
  alias Forum.{Thread, Comment, Repo}

  def new(conn, _params) do
    changeset = Thread.changeset(%Thread{}, %{})

    conn
    |> render("new.html", changeset: changeset)
  end

  def index(conn, _params) do
    threads = Forum.get_threads()
    render(conn, "index.html", threads: threads)
  end

  def create(conn, %{"thread" => thread}) do
    thread
    |> Forum.create_thread()
    |> handle_form_response(conn, "new.html")
  end

  def show(conn, %{"id" => thread_id}) do
    changeset = Comment.changeset(%{})

    thread_id
    |> Forum.fetch_thread()
    |> handle_show(conn, changeset)
  end

  def delete(conn, %{"id" => thread_id}) do
    thread_id
    |> Forum.delete_thread()
    |> handle_delete(conn)
  end

  defp handle_delete({:ok, _thread}, conn) do
    conn
    |> put_flash(:info, "The thread has been deleted")
    |> redirect(to: Routes.thread_path(conn, :index))
  end

  defp handle_delete({:error, message}, conn) do
    conn
    |> put_flash(:error, message)
    |> redirect(to: Routes.thread_path(conn, :index))
  end

  defp handle_show({:ok, thread}, conn, changeset) do
    render(conn, "show.html",
      thread: Repo.preload(thread, :comments),
      changeset: changeset,
      thread_id: thread.id
    )
  end

  defp handle_show({:error, message}, conn, _changeset) do
    conn
    |> put_flash(:error, message)
    |> redirect(to: Routes.thread_path(conn, :index))
  end

  defp handle_form_response({:ok, _thread}, conn, _view) do
    conn
    |> put_flash(:info, "Thread created")
    |> redirect(to: Routes.thread_path(conn, :index))
  end

  defp handle_form_response({:error, thread} = _error, conn, view),
    do: render(conn, view, changeset: thread)
end
