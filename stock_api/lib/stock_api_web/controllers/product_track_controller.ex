defmodule StockApiWeb.ProductTrackController do
  use StockApiWeb, :controller

  alias StockApi.Stock
  alias StockApi.Stock.ProductTrack

  action_fallback StockApiWeb.FallbackController

  def index(conn, _params) do
    product_tracks = Stock.list_product_tracks()
    render(conn, "index.json", product_tracks: product_tracks)
  end

  def create(conn, %{"product_track" => product_track_params}) do
    with {:ok, %ProductTrack{} = product_track} <- Stock.create_product_track(product_track_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.product_track_path(conn, :show, product_track))
      |> render("show.json", product_track: product_track)
    end
  end

  def show(conn, %{"id" => id}) do
    product_track = Stock.get_product_track!(id)
    render(conn, "show.json", product_track: product_track)
  end

  def update(conn, %{"id" => id, "product_track" => product_track_params}) do
    product_track = Stock.get_product_track!(id)

    with {:ok, %ProductTrack{} = product_track} <- Stock.update_product_track(product_track, product_track_params) do
      render(conn, "show.json", product_track: product_track)
    end
  end

  def delete(conn, %{"id" => id}) do
    product_track = Stock.get_product_track!(id)

    with {:ok, %ProductTrack{}} <- Stock.delete_product_track(product_track) do
      send_resp(conn, :no_content, "")
    end
  end
end
