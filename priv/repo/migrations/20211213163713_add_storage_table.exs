defmodule Shifu.Repo.Migrations.CreateStorage do
  use Ecto.Migration

  def change do
    create table("storages") do
      add :category, :string
      add :extension, :string
      add :mimeType, :string
      add :name, :string
      add :status, :string, default: "active"
      add :inserted_at, :utc_datetime
      add :updated_at, :utc_datetime
      add :deletedAt, :utc_datetime
    end

    create unique_index(:storages, [:name])
  end
end
