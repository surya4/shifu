defmodule ShifuWeb.IndexControllerTest do
  use ExUnit.Case, async: false
  use Plug.Test
  use ShifuWeb.ConnCase

  describe "Index API  GET /" do
    test "success", %{conn: conn} do
      resp = get(conn, "/")

      assert resp.status == 200
      body = resp.resp_body
      assert String.contains?(body, "content")
      assert String.contains?(body, "info")

      assert json_response(resp, 200) == %{
               "content" => %{
                 "info" => "Shifu Index API",
                 "message" =>
                   "If you are truly at peace, you can do anything."
               }
             }
    end
  end

  describe "Index API  GET /not_found" do
    test "success", %{conn: conn} do
      resp = get(conn, "/not_found")

      assert resp.status == 404
      body = resp.resp_body
      assert String.contains?(body, "error")

      assert json_response(resp, 404) == %{
               "error" => %{
                 "message" =>
                   "API not found. Please check the API URL and request method type."
               }
             }
    end
  end
end
