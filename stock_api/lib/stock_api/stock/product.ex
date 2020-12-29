defmodule StockApi.Stock.Product do
  use Ecto.Schema
  import Ecto.Changeset

  @derive Jason.Encoder

  @primary_key {:id, :binary_id, autogenerate: true}

  @derive {Jason.Encoder, []}
  schema "products" do
    field :code, :string
    field :description, :string
    field :suggest_price, :decimal
    field :real_price, :decimal
    field :consultant_price, :decimal
    field :observation, :string
    field :barcode, :string


    field :images, {:array, :string}

    has_many :product_tracks, StockApi.Stock.ProductTrack

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:code, :description, :suggest_price, :real_price, :consultant_price])
    |> validate_required([:code, :description, :suggest_price])
    |> validate_number(:real_price, greater_than_or_equal_to: 0)
    |> validate_number(:consultant_price, greater_than_or_equal_to: 0)
  end
end
