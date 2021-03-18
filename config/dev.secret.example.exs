import Config

config :forum, Forum.Repo,
  # Pass the url with all credentials
  url: "ecto://user:password@localhost:5432/forum",

  # Or pass the credentials separately
  username: "user",
  password: "password",
  database: "forum",
  hostname: "localhost"
