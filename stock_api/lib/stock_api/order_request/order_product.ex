defmodule StockApi.OrderRequest.OrderProduct do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "order_products" do
    field :consultant_price, :decimal
    field :delivered_at, :date
    field :description, :string
    field :observation, :string
    field :quantity, :integer
    field :real_price, :decimal
    field :suggest_price, :decimal

    belongs_to :order, StockApi.OrderRequest.Order

    timestamps()
  end

  @doc false
  def changeset(order_product, attrs) do
    order_product
    |> cast(attrs, [
      :description,
      :quantity,
      :suggest_price,
      :real_price,
      :consultant_price
    ])
    |> validate_required([
      :description,
      :quantity,
      :suggest_price,
      :real_price,
      :consultant_price
    ])
    |> validate_number(:quantity, greater_than_or_equal_to: 0)
    |> validate_number(:suggest_price, greater_than_or_equal_to: 0)
    |> validate_number(:real_price, greater_than_or_equal_to: 0)
    |> validate_number(:consultant_price, greater_than_or_equal_to: 0)
  end
end
