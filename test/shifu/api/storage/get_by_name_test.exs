defmodule ShifuWeb.StorageControllerTest do
  use ExUnit.Case, async: false
  use Plug.Test
  use ShifuWeb.ConnCase
  use ExMachina
  use Shifu.Repo
  import Shifu.Factory

  alias Shifu.Helpers.Files

  describe "Storage API: GET storage/:name" do
    test "failed: name not found", %{conn: conn} do
      file_name = "file_not_found"
      resp = get(conn, "/storage/#{file_name}")

      assert resp.status == 404
      body = resp.resp_body
      assert String.contains?(body, "error")

      assert json_response(resp, 404) == %{
               "error" => %{
                 "message" => "File not found for: #{file_name}"
               }
             }
    end

    test "failed: name present in trash", %{conn: conn} do
      file_name = "trashed_file"
      insert(:storage, name: file_name, status: "trash")
      resp = get(conn, "/storage/#{file_name}")

      assert resp.status == 404
      body = resp.resp_body

      assert String.contains?(body, "error")

      assert json_response(resp, 404) == %{
               "error" => %{
                 "message" =>
                   "This file was trashed, you can restore the file from trash if needed."
               }
             }
    end

    test "failed: unable_to_stream", %{conn: conn} do
      file_name = "unable_to_stream.mp3"
      insert(:storage, name: file_name, status: "active")

      resp = get(conn, "/storage/#{file_name}")

      assert resp.status == 400
      body = resp.resp_body

      assert String.contains?(body, "error")

      assert json_response(resp, 400) == %{
               "error" => %{
                 "message" => "Not able to stream the file currently. Please try again later."
               }
             }
    end

    test "success: able to stream", %{conn: conn} do
      Application.put_env(:shifu, :storage_upload_path, "./")
      file_name = "success.mp3"
      file_path = Files.get_storage_file_path(file_name)
      File.touch(file_path)

      insert(:storage, name: file_name, status: "active")

      resp = get(conn, "/storage/#{file_name}")

      assert resp.status == 200
      assert get_resp_header(resp, "content-type") == ["audio/mp3"]

      assert get_resp_header(resp, "content-disposition") == [
               "filename=#{file_name}"
             ]

      File.rm_rf!(file_path)
    end
  end
end
