defmodule StockApiWeb.OrderProductController do
  use StockApiWeb, :controller

  alias StockApi.OrderRequest
  alias StockApi.OrderRequest.OrderProduct

  action_fallback StockApiWeb.FallbackController

  def index(conn, _params) do
    order_products = OrderRequest.list_order_products()
    render(conn, "index.json", order_products: order_products)
  end

  def create(conn, %{"order_product" => order_product_params}) do
    with {:ok, %OrderProduct{} = order_product} <- OrderRequest.create_order_product(order_product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_product_path(conn, :show, order_product))
      |> render("show.json", order_product: order_product)
    end
  end

  def show(conn, %{"id" => id}) do
    order_product = OrderRequest.get_order_product!(id)
    render(conn, "show.json", order_product: order_product)
  end

  def update(conn, %{"id" => id, "order_product" => order_product_params}) do
    order_product = OrderRequest.get_order_product!(id)

    with {:ok, %OrderProduct{} = order_product} <- OrderRequest.update_order_product(order_product, order_product_params) do
      render(conn, "show.json", order_product: order_product)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_product = OrderRequest.get_order_product!(id)

    with {:ok, %OrderProduct{}} <- OrderRequest.delete_order_product(order_product) do
      send_resp(conn, :no_content, "")
    end
  end
end
