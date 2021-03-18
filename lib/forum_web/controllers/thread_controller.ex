defmodule ForumWeb.ThreadController do
  use ForumWeb, :controller
  alias Forum.{Thread, Comment}
  alias ForumWeb.ControllersHelpers

  def new(conn, _params) do
    changeset = Thread.changeset(%Thread{}, %{})

    conn
    |> render("new.html",
      changeset: changeset
    )
  end

  def index(conn, params) do
    {page, ""} =
      Map.get(params, "page", "1")
      |> Integer.parse()

    result = Forum.get_threads(count_comments: true, page: page)

    render(conn, "index.html",
      threads: result.entries,
      total_pages: result.total_pages,
      current_page: result.page_number
    )
  end

  def create(conn, %{"thread" => thread}) do
    case Forum.create_thread(thread) do
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)

      {:ok, thread} ->
        redirect(conn, to: Routes.thread_path(conn, :show, thread.id))
    end
  end

  def show(conn, params) do
    changeset = Comment.changeset(%{})

    %{"id" => thread_id} = params

    {page, ""} =
      Map.get(params, "page", "1")
      |> Integer.parse()

    case Forum.fetch_thread(thread_id) do
      {:ok, thread} ->
        ControllersHelpers.handle_show_thread(conn, thread, changeset, page)

      {:error, message} ->
        redirect_flash_index(conn, message, :error)
    end
  end

  def delete(conn, %{"id" => thread_id}) do
    case Forum.delete_thread(thread_id) do
      {:ok, _thread} -> redirect_flash_index(conn, "The thread ##{thread_id} has been deleted")
      {:error, message} -> redirect_flash_index(conn, message, :error)
    end
  end

  defp redirect_flash_index(conn, message, flash_type \\ :info, path \\ :index),
    do: ControllersHelpers.redirect_flash(conn, flash_type, message, path, [])
end
