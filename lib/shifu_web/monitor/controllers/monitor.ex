defmodule ShifuWeb.MonitorController do
  use ShifuWeb, :controller
  alias Ecto.Adapters.SQL
  alias Shifu.Helpers.Response

  require Logger

  def postgres_health_check do
    case SQL.query(Shifu.Repo, "SELECT 1;", []) do
      {:ok, _} ->
        true

      err ->
        Logger.error("Failed to connect with Postgres: #{inspect(err)}")
        false
    end
  end

  def health(conn, _params) do
    postgres_health = postgres_health_check()

    payload = %{
      postgres: postgres_health
    }

    if postgres_health != true do
      Response.failure(conn, :custom_error, payload)
    else
      Response.success(conn, payload)
    end
  end
end
