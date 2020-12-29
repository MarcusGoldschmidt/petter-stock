defmodule StockApiWeb.OrderView do
  use StockApiWeb, :view
  alias StockApiWeb.OrderView

  def render("index.json", %{orders: orders}) do
    %{data: render_many(orders, OrderView, "order.json")}
  end

  def render("show.json", %{order: order}) do
    %{data: render_one(order, OrderView, "order.json")}
  end

  def render("order.json", %{order: order}) do
    %{id: order.id,
      number: order.number,
      period: order.period}
  end
end
