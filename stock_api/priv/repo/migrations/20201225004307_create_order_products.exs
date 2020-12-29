defmodule StockApi.Repo.Migrations.CreateOrderProducts do
  use Ecto.Migration

  def change do
    create table(:order_products, primary_key: false) do

      add :id, :uuid, primary_key: true
      add :description, :text, null: false
      add :quantity, :integer, null: false
      add :suggest_price, :decimal, null: false
      add :real_price, :decimal, default: 0
      add :consultant_price, :decimal, default: 0
      add :observation, :string
      add :delivered_at, :date

      add :order_id, references(:orders, type: :uuid), null: false

      timestamps()
    end

  end
end
