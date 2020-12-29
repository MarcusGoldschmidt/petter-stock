defmodule StockApiWeb.ProductView do
  use StockApiWeb, :view
  alias StockApiWeb.ProductView

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      code: product.code,
      description: product.description,
      suggestPrice: product.suggest_price,
      realPrice: product.real_price,
      consultantPrice: product.consultant_price,
      observation: product.observation,
      images: product.images,
      barcode: product.barcode
    }
  end
end
