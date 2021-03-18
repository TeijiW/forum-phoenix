defmodule ForumWeb.CommentControllerTest do
  use ForumWeb.ConnCase

  @create_attrs %{
    message: "Hey! It's just a test, relax",
    username: "johndoe_tester"
  }
  @invalid_attrs %{
    message:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi viverra in mauris sed vehicula. Morbi sit amet diam et odio maximus consectetur. Donec fermentum magna vitae risus cursus mattis nec pellentesque leo. In urna mauris, pellentesque orci aliquam.",
    username: nil
  }

  @create_thread_attrs %{
    title: "Test thread",
    username: "John Doe",
    description: "Just a test"
  }

  def fixture(:comment) do
    {:ok, comment} = Forum.create_comment(Map.merge(@create_attrs, create_thread(nil)))
    comment
  end

  defp create_thread(_) do
    {:ok, thread} = Forum.create_thread(@create_thread_attrs)
    %{thread_id: thread.id}
  end

  defp create_comment(_) do
    comment = fixture(:comment)
    %{comment: comment}
  end

  describe "Create comment" do
    setup [:create_thread]

    test "Redirect to 'thread details' page and add the comment to thread comments list when data is valid",
         %{
           conn: conn,
           thread_id: thread_id
         } do
      comment = Map.put(@create_attrs, :thread_id, thread_id)
      conn = post(conn, Routes.thread_comment_path(conn, :create, thread_id), comment: comment)

      assert redirected_to(conn) == Routes.thread_path(conn, :show, thread_id)

      get(conn, Routes.thread_path(conn, :show, thread_id))
      |> html_response(200)
      |> assert() =~ comment.message
    end

    test "Redirect to 'thread details' and show the comment form errors when the data is invalid",
         %{
           conn: conn,
           thread_id: thread_id
         } do
      comment = Map.put(@invalid_attrs, :thread_id, thread_id)

      post(conn, Routes.thread_comment_path(conn, :create, thread_id), comment: comment)
      |> html_response(200)
      |> assert() =~ "blank"
    end
  end

  describe "Delete comment" do
    setup [:create_comment]

    test "Delete a comment", %{conn: conn, comment: comment} do
      conn =
        delete(conn, Routes.thread_comment_path(conn, :delete, comment.thread_id, comment.id))

      redir_path = redirected_to(conn, 302)
      conn = get(recycle(conn), redir_path)
      assert html_response(conn, 200) =~ "deleted"
    end
  end
end
