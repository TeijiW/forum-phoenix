defmodule Forum.Comment.Create do
  alias Forum.{Repo, Comment}

  def call(params) do
    params
    |> Comment.build()
    |> create_comment()
  end

  defp create_comment({:error, _struct} = error), do: error
  defp create_comment({:ok, struct}), do: Repo.insert(struct)
end
