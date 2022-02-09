defmodule ShifuWeb.Storage.StorageController do
  alias Shifu.Helpers.Files
  alias Shifu.Helpers.Response
  alias Shifu.Storage.Files, as: FileService

  use ShifuWeb, :controller
  require Logger

  def get_by_name(conn, params) do
    name = params["name"]
    storage_file = FileService.get_by_name(name)

    cond do
      is_nil(storage_file) == true ->
        Response.failure(conn, :file_not_found, name)

      storage_file.status === :trash ->
        Response.failure(conn, :trashed_file)

      true ->
        try do
          file_path = Files.get_storage_file_path(storage_file.name)
          file_content_disposition = Files.get_file_disposition(storage_file.name)

          conn
          |> put_resp_header("content-type", storage_file.mimeType)
          |> put_resp_header("content-disposition", file_content_disposition)
          |> send_file(200, file_path)
        rescue
          e ->
            Logger.error("Error streaming: #{inspect(e)}")
            Response.failure(conn, :unable_to_stream)
        end
    end
  end
end
