defmodule Forum.Thread.Fetch do
  alias Forum.{Thread, Repo}

  def call(id) do
    case Integer.parse(id) do
      {id, ""} -> get(id)
      _ -> {:error, "Invalid thread id format"}
    end
  end

  def get(id) do
    case Repo.get(Thread, id) do
      nil -> {:error, "Thread ##{id} not found!"}
      thread -> {:ok, thread}
    end
  end
end
