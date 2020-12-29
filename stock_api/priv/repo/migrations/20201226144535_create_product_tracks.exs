defmodule StockApi.Repo.Migrations.CreateProductTracks do
  use Ecto.Migration

  def change do
    create table(:product_tracks, primary_key: false) do

      add :id, :uuid, primary_key: true

      add :quantity, :integer, default: 0
      add :expiration_date, :date, null: false

      add :product_id, references(:products, type: :uuid), null: false

      timestamps()
    end

  end
end
