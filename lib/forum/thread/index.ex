defmodule Forum.Thread.Index do
  import Ecto.Query
  alias Forum.{Repo, Thread}

  def call(option \\ false) do
    threads = Repo.all(Thread)

    case option do
      :with_comments_count -> with_comments(threads)
      _ -> threads
    end
  end

  def with_comments(threads), do: Enum.map(threads, fn t -> count_comments(t) end)

  defp count_comments(thread) do
    query = from comment in "comment", where: comment.thread_id == ^thread.id
    count = Repo.aggregate(query, :count, :id)
    thread |> Map.put(:comments_count, count)
  end
end
