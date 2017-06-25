defmodule Namuraid.Router do
  use Namuraid.Web, :router

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

  scope "/", Namuraid do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/live", LiveController, :index
    post "/live", LiveController, :create

    get "/start", StartController, :index
    post "/start", StartController, :create

    get "/result", ResultController, :index
    post "/result", ResultController, :create

    resources "/screens", ScreenController
    resources "/sitewalk", SiteWalkController
    resources "/sponsors", SponsorController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Namuraid do
  #   pipe_through :api
  # end
end
