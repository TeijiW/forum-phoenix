defmodule Forum.Thread.Create do
  alias Forum.{Repo, Thread}

  def call(params) do
    params
    |> Thread.build()
    |> create_thread()
  end

  defp create_thread({:error, _struct} = error), do: error
  defp create_thread({:ok, struct}), do: Repo.insert(struct)
end
