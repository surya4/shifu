defmodule ShifuWeb.Router do
  use ShifuWeb, :router
  use Plug.ErrorHandler
  alias Shifu.Helpers.Response
  require Logger

  pipeline :public_api do
    plug :accepts, ["json"]
  end

  scope "/", ShifuWeb do
    pipe_through [:public_api]

    get "/", IndexController, :index
  end

  scope "/monitor", ShifuWeb do
    pipe_through [:public_api]

    get "/health", MonitorController, :health
  end

  scope "/storage", ShifuWeb.Storage do
    pipe_through [:public_api]

    get "/:name", StorageController, :get_by_name
  end

  scope "/", ShifuWeb do
    get "/*path", IndexController, :not_found
  end

  def handle_errors(conn, error) do
    Logger.error("handle_errors: #{inspect(error)}")
    Response.failure(conn, :server_error)
  end
end
