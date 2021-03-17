import Config

config :forum, Forum.Repo,
  url: "ecto://user:password@localhost:5432/forum",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,

  # Or pass the credentials separately
  username: "user",
  password: "password",
  database: "forum",
  hostname: "localhost"
