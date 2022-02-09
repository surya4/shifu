defmodule ShifuWeb.IndexController do
  use ShifuWeb, :controller
  alias Shifu.Helpers.Response

  require Logger

  def index(conn, _params) do
    payload = %{
      message:
        "If you are truly at peace, you can do anything.",
      info: "Shifu Index API"
    }

    Response.success(conn, payload)
  end

  def not_found(conn, _params) do
    Response.failure(conn, :api_not_found)
  end
end
