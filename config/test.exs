use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :forum, Forum.Repo, pool: Ecto.Adapters.SQL.Sandbox
import_config "dev.secret.exs"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :forum, ForumWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
