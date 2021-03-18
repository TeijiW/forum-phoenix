# Forum

## Requirements

- PostgreSQL
- Erlang and Elixir
- Mix

## Steps to start the server

  1. Please, set database credentials config on `config/dev.secret.exs` file **based** on `config/dev.secret.example.exs` file
  2. Install dependencies with `mix deps.get`
  3. Create and migrate your database with `mix ecto.setup`
  4. Install Node.js dependencies with `npm install` inside the `assets` directory
  5. Start Phoenix endpoint with `mix phx.server`
  6. (optional) Execute the tests with `mix test`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser and see the forum!.
