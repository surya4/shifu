defmodule Shifu.Storage.Files do
  use Shifu.Repo
  alias Shifu.StorageSchema

  def get_by_name(name) do
    Repo.get_by(StorageSchema, name: name)
  end
end
