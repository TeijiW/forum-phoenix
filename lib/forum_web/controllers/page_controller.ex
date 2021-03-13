defmodule ForumWeb.PageController do
  use ForumWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
