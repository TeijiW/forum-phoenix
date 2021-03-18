defmodule ForumWeb.ThreadControllerTest do
  use ForumWeb.ConnCase

  @create_attrs %{
    title: "Test thread",
    username: "John Doe",
    description: "Just a test"
  }
  @invalid_attrs %{
    title: nil,
    username:
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi viverra in mauris sed vehicula. Morbi sit amet diam et odio maximus consectetur. Donec fermentum magna vitae risus cursus mattis nec pellentesque leo. In urna mauris, pellentesque orci aliquam.",
    description: nil
  }

  def fixture(:thread) do
    {:ok, thread} = Forum.create_thread(@create_attrs)
    thread
  end

  test "GET index", %{conn: conn} do
    conn = get(conn, Routes.thread_path(conn, :index))
    assert html_response(conn, 200) =~ "Threads"
  end

  describe "Create thread" do
    test "Redirects to thread list when data is valid", %{conn: conn} do
      conn = post(conn, Routes.thread_path(conn, :create), thread: @create_attrs)
      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.thread_path(conn, :show, id)

      get(conn, Routes.thread_path(conn, :show, id))
      |> html_response(200)
      |> assert() =~ id
    end

    test "Show errors when data is invalid", %{conn: conn} do
      post(conn, Routes.thread_path(conn, :create), thread: @invalid_attrs)
      |> html_response(200)
      |> assert() =~ "new thread"
    end
  end

  describe "Delete thread" do
    setup [:create_thread]

    test "Delete a thread", %{conn: conn, thread: thread} do
      conn = delete(conn, Routes.thread_path(conn, :delete, thread))
      redir_path = redirected_to(conn, 302)
      conn = get(recycle(conn), redir_path)
      assert html_response(conn, 200) =~ "deleted"
    end
  end

  defp create_thread(_) do
    thread = fixture(:thread)
    %{thread: thread}
  end
end
