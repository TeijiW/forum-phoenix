defmodule Forum.Thread.Fetch do
  alias Forum.{Thread, Repo}

  def call(id) do
    case Repo.get(Thread, id) do
      nil -> {:error, "Thread not found!"}
      thread -> {:ok, thread}
    end
  end
end
