defmodule Forum.Thread.Fetch do
  alias Forum.{Thread, Repo}
  alias Ecto.UUID

  def call(id) do
    case UUID.cast(id) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case Repo.get(Thread, uuid) do
      nil -> {:error, "Thread not found!"}
      thread -> {:ok, thread}
    end
  end
end
