defmodule ForumWeb.ThreadController do
  use ForumWeb, :controller
  alias Forum.{Thread, Comment}

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
    {:ok, thread = %Thread{}} =
      thread_id
      |> Forum.fetch_thread()

    changeset = Comment.changeset(%{})
    # IO.inspect(changeset)

    render(conn, "show.html", thread: thread, changeset: changeset, thread_id: thread_id)
  end

  defp handle_form_response({:ok, _thread}, conn, _view) do
    conn
    |> put_flash(:info, "Thread created")
    |> redirect(to: Routes.thread_path(conn, :index))
  end

  defp handle_form_response({:error, thread} = _error, conn, view),
    do: render(conn, view, changeset: thread)
end
