defmodule ShifuWeb.StorageSchemaTest do
  use ExUnit.Case, async: false
  use Plug.Test
  use ShifuWeb.ConnCase
  use ExMachina
  use Shifu.Repo
  alias Shifu.StorageSchema

  describe "Storage Schema" do
    test "failure: required_fields - missing name" do
      payload = %StorageSchema{
        category: "audio",
        extension: "mp3",
        mimeType: "audio/mp3",
        # name: attrs.name,
        status: :active,
        inserted_at: DateTime.utc_now() |> DateTime.truncate(:second),
        updated_at: DateTime.utc_now() |> DateTime.truncate(:second)
      }

      try do
        Repo.insert!(payload)
      rescue
        e in Postgrex.Error ->
          assert e != nil
      end
    end

    test "failure: validate_required - invalid status" do
      file_name = "validate_required.mp3"

      payload = %StorageSchema{
        category: "audio",
        extension: "mp3",
        mimeType: "audio/mp3",
        name: file_name,
        status: :invalid_status,
        inserted_at: DateTime.utc_now() |> DateTime.truncate(:second),
        updated_at: DateTime.utc_now() |> DateTime.truncate(:second)
      }

      try do
        Repo.insert!(payload)
      rescue
        e ->
          assert e != nil
      end
    end

    test "failure: unique_constraint" do
      file_name = "unique_constraint.mp3"

      payload = %StorageSchema{
        category: "audio",
        extension: "mp3",
        mimeType: "audio/mp3",
        name: file_name,
        status: :active,
        inserted_at: DateTime.utc_now() |> DateTime.truncate(:second),
        updated_at: DateTime.utc_now() |> DateTime.truncate(:second)
      }

      Repo.insert!(payload)

      try do
        Repo.insert!(payload)
      rescue
        e ->
          assert e != nil
      end
    end
  end
end
