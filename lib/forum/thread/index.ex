defmodule Forum.Thread.Index do
  alias Forum.{Repo, Thread}

  def call() do
    Repo.all(Thread)
  end
end
