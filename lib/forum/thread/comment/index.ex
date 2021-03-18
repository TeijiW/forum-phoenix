defmodule Forum.Thread.Comment.Index do
  import Ecto.Query
  alias Forum.{Repo, Comment}

  def call(thread_id, page \\ 1) do
    Comment
    |> where(thread_id: ^thread_id)
    |> order_by(desc: :inserted_at)
    |> Repo.paginate(page: page)
  end
end
