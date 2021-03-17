defmodule Forum do
  alias Forum.{Thread, Comment}

  defdelegate create_thread(params), to: Thread.Create, as: :call
  defdelegate get_threads(options \\ []), to: Thread.Index, as: :call
  defdelegate fetch_thread(thread_id), to: Thread.Fetch, as: :call
  defdelegate delete_thread(thread_id), to: Thread.Delete, as: :call

  defdelegate create_comment(params), to: Comment.Create, as: :call
end
