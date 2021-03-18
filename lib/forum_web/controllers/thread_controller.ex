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
        handle_show_thread(conn, thread, changeset, page)

      {:error, message} ->
        redirect_flash_index(conn, message, :error)
    end
  end

  defp handle_show_thread(conn, thread, changeset, page) do
    %{:entries => comments, :total_pages => total_pages, :page_number => current_page} =
      Forum.get_thread_comments(thread.id, page)

    render(conn, "show.html",
      thread: thread,
      comments: comments,
      total_pages: total_pages,
      current_page: current_page,
      changeset: changeset,
      thread_id: thread.id,
      show_thread_list_button: true
    )
  end

  def delete(conn, %{"id" => thread_id}) do
    case Forum.delete_thread(thread_id) do
      {:ok, _thread} -> redirect_flash_index(conn, "The thread ##{thread_id} has been deleted")
      {:error, message} -> redirect_flash_index(conn, message, :error)
    end
  end

  defp redirect_flash_index(conn, message, flash_type \\ :info, path \\ :index),
    # do: conn |> put_flash(flash_type, message) |> redirect(to: Routes.thread_path(conn, path))
    do: ControllersHelpers.redirect_flash(conn, flash_type, message, path, [])
end
