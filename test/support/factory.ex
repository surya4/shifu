defmodule Shifu.Factory do
  use ExMachina.Ecto, repo: Shifu.Repo

  def storage_factory(attrs) do
    storage = %Shifu.StorageSchema{
      category: "audio",
      extension: "mp3",
      mimeType: "audio/mp3",
      name: attrs.name,
      status: attrs.status,
      inserted_at: DateTime.utc_now() |> DateTime.truncate(:second),
      updated_at: DateTime.utc_now() |> DateTime.truncate(:second)
    }

    merge_attributes(storage, attrs)
  end
end
