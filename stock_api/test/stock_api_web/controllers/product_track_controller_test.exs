defmodule StockApiWeb.ProductTrackControllerTest do
  use StockApiWeb.ConnCase

  alias StockApi.Stock
  alias StockApi.Stock.ProductTrack

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  def fixture(:product_track) do
    {:ok, product_track} = Stock.create_product_track(@create_attrs)
    product_track
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all product_tracks", %{conn: conn} do
      conn = get(conn, Routes.product_track_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create product_track" do
    test "renders product_track when data is valid", %{conn: conn} do
      conn = post(conn, Routes.product_track_path(conn, :create), product_track: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.product_track_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.product_track_path(conn, :create), product_track: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update product_track" do
    setup [:create_product_track]

    test "renders product_track when data is valid", %{conn: conn, product_track: %ProductTrack{id: id} = product_track} do
      conn = put(conn, Routes.product_track_path(conn, :update, product_track), product_track: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.product_track_path(conn, :show, id))

      assert %{
               "id" => id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, product_track: product_track} do
      conn = put(conn, Routes.product_track_path(conn, :update, product_track), product_track: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete product_track" do
    setup [:create_product_track]

    test "deletes chosen product_track", %{conn: conn, product_track: product_track} do
      conn = delete(conn, Routes.product_track_path(conn, :delete, product_track))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.product_track_path(conn, :show, product_track))
      end
    end
  end

  defp create_product_track(_) do
    product_track = fixture(:product_track)
    %{product_track: product_track}
  end
end
