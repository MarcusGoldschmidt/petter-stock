defmodule StockApiWeb.OrderController do
  use StockApiWeb, :controller

  alias StockApi.OrderRequest
  alias StockApi.OrderRequest.Order

  action_fallback StockApiWeb.FallbackController

  def index(conn, _params) do
    orders = OrderRequest.list_orders()
    render(conn, "index.json", orders: orders)
  end

  def create(conn, %{"order" => order_params}) do
    with {:ok, %Order{} = order} <- OrderRequest.create_order(order_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.order_path(conn, :show, order))
      |> render("show.json", order: order)
    end
  end

  def show(conn, %{"id" => id}) do
    order = OrderRequest.get_order!(id)
    render(conn, "show.json", order: order)
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = OrderRequest.get_order!(id)

    with {:ok, %Order{} = order} <- OrderRequest.update_order(order, order_params) do
      render(conn, "show.json", order: order)
    end
  end

  def delete(conn, %{"id" => id}) do
    order = OrderRequest.get_order!(id)

    with {:ok, %Order{}} <- OrderRequest.delete_order(order) do
      send_resp(conn, :no_content, "")
    end
  end
end
