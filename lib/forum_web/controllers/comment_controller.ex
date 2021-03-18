defmodule ForumWeb.CommentController do
  use ForumWeb, :controller

  alias Forum.Thread
  alias ForumWeb.ControllersHelpers

  def create(conn, params) do
    %{"comment" => %{"message" => message, "username" => username}, "thread_id" => thread_id} =
      params

    %{
      thread_id: thread_id,
      message: message,
      username: username
    }
    |> Forum.create_comment()
    |> handle_form_response(conn, thread_id)
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

  defp handle_form_response({:ok, _comment}, conn, thread_id) do
    conn
    |> put_flash(:info, "Comment Added")
    |> redirect(to: Routes.thread_path(conn, :show, thread_id))
  end

  defp handle_form_response({:error, comment} = _error, conn, thread_id) do
    {:ok, thread = %Thread{}} =
      thread_id
      |> Forum.fetch_thread()

    ControllersHelpers.handle_show_thread(conn, thread, comment, 1)
  end

  defp redirect_flash_thread_details(
         conn,
         message,
         flash_type,
         thread_id
       ),
       do: ControllersHelpers.redirect_flash(conn, flash_type, message, :show, thread_id)
end
