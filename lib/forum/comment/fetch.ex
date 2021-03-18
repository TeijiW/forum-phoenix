defmodule Forum.Comment.Fetch do
  alias Forum.{Comment, Repo}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Comment, uuid) do
      nil -> {:error, "Comment not found!"}
      comment -> {:ok, comment}
    end
  end
end
