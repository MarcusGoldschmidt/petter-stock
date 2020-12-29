defmodule StockApi.Stock.ProductTrack do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "product_tracks" do
    field :quantity, :integer, default: 0
    field :expiration_date, :date, null: false

    belongs_to :product, StockApi.Stock.Product, type: :binary_id

    timestamps()
  end

  @doc false
  def changeset(product_track, attrs) do
    product_track
    |> cast(attrs, [:quantity, :expiration_date])
    |> validate_required([:quantity, :expiration_date])
  end
end
