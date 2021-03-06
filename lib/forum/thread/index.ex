defmodule Forum.Thread.Index do
  import Ecto.Query
  alias Forum.{Repo, Thread}

  def call(options \\ []) do
    count_comments = Keyword.get(options, :count_comments, false)
    page = Keyword.get(options, :page, 1)

    result =
      Thread
      |> order_by(desc: :inserted_at)
      |> Repo.paginate(page: page)

    if count_comments,
      do: Map.merge(result, %{entries: with_comments_count(result.entries)}),
      else: result
  end

  def with_comments_count(threads), do: Enum.map(threads, fn t -> count_comments(t) end)

  defp count_comments(thread) do
    query = from comment in "comment", where: comment.thread_id == ^thread.id
    count = Repo.aggregate(query, :count, :id)
    thread |> Map.put(:comments_count, count)
  end
end
