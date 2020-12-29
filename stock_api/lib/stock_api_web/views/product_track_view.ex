defmodule StockApiWeb.ProductTrackView do
  use StockApiWeb, :view
  alias StockApiWeb.ProductTrackView

  def render("index.json", %{product_tracks: product_tracks}) do
    %{data: render_many(product_tracks, ProductTrackView, "product_track.json")}
  end

  def render("show.json", %{product_track: product_track}) do
    %{data: render_one(product_track, ProductTrackView, "product_track.json")}
  end

  def render("product_track.json", %{product_track: product_track}) do
    %{
      id: product_track.id,
      quantity: product_track.quantity,
      expirationDate: product_track.expiration_date
    }
  end
end
