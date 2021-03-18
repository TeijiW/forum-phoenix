defmodule Forum.Comment.Delete do
  alias Forum.{Repo}

  def call(id) do
    case Forum.fetch_comment(id) do
      {:error, message} -> {:error, message}
      {:ok, thread} -> Repo.delete(thread)
    end
  end
end
