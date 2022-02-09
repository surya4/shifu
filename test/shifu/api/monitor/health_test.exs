defmodule ShifuWeb.MonitorControllerTest do
  use ExUnit.Case, async: false
  use Plug.Test
  use ShifuWeb.ConnCase

  describe "Monitor Health API: GET monitor/health" do
    test "success", %{conn: conn} do
      resp = get(conn, "/monitor/health")

      assert resp.status == 200
      body = resp.resp_body
      assert String.contains?(body, "content")

      assert json_response(resp, 200) == %{
               "content" => %{
                 "postgres" => true
               }
             }
    end
  end
end
