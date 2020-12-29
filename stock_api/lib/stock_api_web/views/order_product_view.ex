defmodule StockApiWeb.OrderProductView do
  use StockApiWeb, :view
  alias StockApiWeb.OrderProductView

  def render("index.json", %{order_products: order_products}) do
    %{data: render_many(order_products, OrderProductView, "order_product.json")}
  end

  def render("show.json", %{order_product: order_product}) do
    %{data: render_one(order_product, OrderProductView, "order_product.json")}
  end

  def render("order_product.json", %{order_product: order_product}) do
    %{id: order_product.id,
      description: order_product.description,
      quantity: order_product.quantity,
      suggest_price: order_product.suggest_price,
      real_price: order_product.real_price,
      consultant_price: order_product.consultant_price,
      observation: order_product.observation,
      delivered_at: order_product.delivered_at}
  end
end
