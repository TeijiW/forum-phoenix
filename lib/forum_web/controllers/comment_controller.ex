defmodule ForumWeb.CommentController do
  use ForumWeb, :controller

  def create(conn, params) do
    %{"comment" => %{"message" => message, "username" => username}, "thread_id" => thread_id} =
      params

    %{
      thread_id: thread_id,
      message: message,
      username: username
    }
    |> Forum.create_comment()
    |> handle_form_response(conn, "show.html")
  end

  defp handle_form_response({:ok, _comment}, conn, _view) do
    conn
    |> put_flash(:info, "Comment Added")
    |> redirect(to: Routes.thread_path(conn, :show, "35f8880f-18a6-45f8-978b-ec9551905c7a"))
  end

  defp handle_form_response({:error, comment} = _error, conn, view) do
    conn
    |> put_view(Forum.ThreadView)
    |> render(view, changeset: comment)
  end
end
