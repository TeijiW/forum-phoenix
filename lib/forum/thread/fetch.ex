defmodule Forum.Thread.Fetch do
  alias Forum.{Thread, Repo}

  def call(id) do
    case is_integer(id) do
      true -> get(id)
      _ -> {:error, "Invalid thread id format"}
    end
  end

  def get(id) do
    case Repo.get(Thread, id) do
      nil -> {:error, "Thread not found!"}
      thread -> {:ok, thread}
    end
  end
end
