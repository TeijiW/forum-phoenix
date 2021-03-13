defmodule Forum do
  alias Forum.Thread

  defdelegate create_thread(params), to: Thread.Create, as: :call
  defdelegate get_threads(), to: Thread.Index, as: :call
end
