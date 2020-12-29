defmodule StockApi.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do

      add :id, :uuid, primary_key: true

      add :code, :string, null: false

      add :description, :text, null: false
      add :suggest_price, :decimal, null: false
      add :real_price, :decimal, default: 0
      add :consultant_price, :decimal, default: 0
      add :observation, :text
      add :barcode, :text

      add :images, {:array, :text}, default: []

      timestamps()
    end

  end
end
