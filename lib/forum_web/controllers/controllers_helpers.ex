defmodule ForumWeb.ControllersHelpers do
  use ForumWeb, :controller

  def redirect_flash(conn, flash_type, message, action, thread_id),
    do:
      conn
      |> put_flash(flash_type, message)
      |> redirect(to: Routes.thread_path(conn, action, thread_id))

  def handle_show_thread(conn, thread, changeset, page) do
    %{:entries => comments, :total_pages => total_pages, :page_number => current_page} =
      Forum.get_thread_comments(thread.id, page)

    conn
    |> put_view(ForumWeb.ThreadView)
    |> render("show.html",
      thread: thread,
      comments: comments,
      total_pages: total_pages,
      current_page: current_page,
      changeset: changeset,
      thread_id: thread.id,
      show_thread_list_button: true
    )
  end
end
