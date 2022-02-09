defmodule Shifu.StorageSchema do
  use Ecto.Schema

  import Ecto.Changeset

  import EctoEnum
  defenum(StatusEnum, active: "active", trash: "trash")

  @required_fields [
    :category,
    :extension,
    :mimeType,
    :name,
    :status
  ]

  schema "storages" do
    field(:category, :string)
    field(:extension, :string)
    field(:mimeType, :string)
    field(:name, :string)
    field(:status, StatusEnum, default: "active")
    field(:inserted_at, :utc_datetime)
    field(:updated_at, :utc_datetime)
    field(:deletedAt, :utc_datetime)
  end

  def changeset(storage, params \\ %{}) do
    storage
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:name)
  end
end
