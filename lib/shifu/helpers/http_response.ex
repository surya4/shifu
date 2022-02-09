defmodule Shifu.Helpers.Response do
  import Plug.Conn

  alias Phoenix.Controller, as: PhxController
  alias Shifu.Helpers.Error

  def send(conn, status, body) do
    conn
    |> put_status(status)
    |> put_resp_content_type("application/json")
    |> PhxController.json(body)
    |> halt()
  end

  def success(conn, content) do
    body = %{
      content: content
    }

    send(conn, 200, body)
  end

  def failure(conn, key) do
    error_map = Error.map(key)

    body = %{
      error: %{
        message: error_map.message
      }
    }

    send(conn, error_map.code, body)
  end

  def failure(conn, key, message) when not is_map(message) do
    error_map = Error.map(key, message)

    body = %{
      error: %{
        message: error_map.message
      }
    }

    send(conn, error_map.code, body)
  end

  def failure(conn, _key, payload) when is_map(payload) do
    body = %{
      error: payload
    }

    send(conn, 500, body)
  end
end
