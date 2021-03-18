defmodule ForumWeb.ControllersHelpers do
  use ForumWeb, :controller

  def redirect_flash(conn, flash_type, message, action, thread_id),
    do:
      conn
      |> put_flash(flash_type, message)
      |> redirect(to: Routes.thread_path(conn, action, thread_id))
end
