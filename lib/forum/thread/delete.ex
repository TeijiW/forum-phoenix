defmodule Forum.Thread.Delete do
  alias Forum.{Repo}

  def call(id) do
    case Forum.fetch_thread(id) do
      {:error, message} -> {:error, message}
      {:ok, thread} -> Repo.delete(thread)
    end
  end
end
