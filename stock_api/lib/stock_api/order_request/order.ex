defmodule StockApi.OrderRequest.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "orders" do
    field :number, :string
    field :period, :string

    has_many :products, StockApi.OrderRequest.OrderProduct

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:number, :period])
    |> validate_required([:number, :period])
  end
end
