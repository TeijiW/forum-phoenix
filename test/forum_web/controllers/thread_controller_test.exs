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

  test "GET index", %{conn: conn} do
    conn = get(conn, Routes.thread_path(conn, :index))
    assert html_response(conn, 200) =~ "Threads"
  end

  describe "Create thread" do
    test "Redirects to thread list when data is valid", %{conn: conn} do
      conn = post(conn, Routes.thread_path(conn, :create), thread: @create_attrs)
      # assert html_response(conn, 302) =~ "Threads"
      # assert %{id: id} = redirected_params(conn)
      # assert redirected_to(conn) == Routes.thread_path(conn, :show, id)
    end
  end
end
