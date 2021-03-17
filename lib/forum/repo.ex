defmodule Forum.Repo do
  use Ecto.Repo,
    otp_app: :forum,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
end
