defmodule StockApiWeb.DefaultController do
  use StockApiWeb, :controller

  def index(conn, _params) do
    json(conn, %{})
  end
end
