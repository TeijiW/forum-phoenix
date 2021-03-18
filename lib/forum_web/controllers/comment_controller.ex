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

  def delete(conn, %{"thread_id" => thread_id, "id" => comment_id}) do
    case Forum.delete_comment(comment_id) do
      {:ok, _thread} ->
        redirect_flash_thread_details(
          conn,
          "The comment has been deleted",
          :info,
          thread_id
        )

      {:error, message} ->
        redirect_flash_thread_details(conn, message, :error, thread_id)
    end
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

  defp redirect_flash_thread_details(
         conn,
         message,
         flash_type,
         thread_id
       ),
       do:
         conn
         |> put_flash(flash_type, message)
         |> redirect(to: Routes.thread_path(conn, :show, thread_id))
end
