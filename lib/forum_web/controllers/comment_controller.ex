defmodule ForumWeb.CommentController do
  use ForumWeb, :controller

  alias Forum.{Thread, Repo}

  def create(conn, params) do
    %{"comment" => %{"message" => message, "username" => username}, "thread_id" => thread_id} =
      params

    %{
      thread_id: thread_id,
      message: message,
      username: username
    }
    |> Forum.create_comment()
    |> handle_form_response(conn, "show.html", thread_id)
  end

  defp handle_form_response({:ok, _comment}, conn, _view, thread_id) do
    conn
    |> put_flash(:info, "Comment Added")
    |> redirect(to: Routes.thread_path(conn, :show, thread_id))
  end

  defp handle_form_response({:error, comment} = _error, conn, view, thread_id) do
    {:ok, thread = %Thread{}} =
      thread_id
      |> Forum.fetch_thread()

    conn
    |> put_view(ForumWeb.ThreadView)
    |> render(view,
      changeset: comment,
      thread: Repo.preload(thread, :comments),
      thread_id: thread_id
    )
  end
end
