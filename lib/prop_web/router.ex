defmodule PropWeb.Router do
  use PropWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PropWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PropWeb do
    pipe_through :browser

    live "/", HomeLive, :index
    live "/scrapes", ScrapeLive, :index
    live("/scrapes/jobs", ScrapeJob.IndexLive, :index, as: :scrape_job)
  end

  scope "/", NotifiedPhoenix do
    pipe_through :browser

    live("/notifications", ListLive, :index,
      as: :notification,
      layout: {SlurpeeWeb.LayoutView, :root}
    )
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PropWeb.Telemetry
    end
  end
end
