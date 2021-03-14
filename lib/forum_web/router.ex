defmodule ForumWeb.Router do
  use ForumWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ForumWeb do
    pipe_through :browser

    get "/", ThreadController, :index
    get "/thread/new", ThreadController, :new
    post "/thread", ThreadController, :create

    resources "/thread", ThreadController, only: [:show] do
      resources "/", CommentController, only: [:create]
    end
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ForumWeb.Telemetry
    end
  end
end
