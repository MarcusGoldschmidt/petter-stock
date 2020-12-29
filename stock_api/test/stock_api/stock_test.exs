defmodule StockApi.StockTest do
  use StockApi.DataCase

  alias StockApi.Stock

  describe "products" do
    alias StockApi.Stock.Product

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stock.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Stock.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Stock.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Stock.create_product(@valid_attrs)
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stock.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Stock.update_product(product, @update_attrs)
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Stock.update_product(product, @invalid_attrs)
      assert product == Stock.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Stock.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Stock.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Stock.change_product(product)
    end
  end

  describe "product_tracks" do
    alias StockApi.Stock.ProductTrack

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def product_track_fixture(attrs \\ %{}) do
      {:ok, product_track} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stock.create_product_track()

      product_track
    end

    test "list_product_tracks/0 returns all product_tracks" do
      product_track = product_track_fixture()
      assert Stock.list_product_tracks() == [product_track]
    end

    test "get_product_track!/1 returns the product_track with given id" do
      product_track = product_track_fixture()
      assert Stock.get_product_track!(product_track.id) == product_track
    end

    test "create_product_track/1 with valid data creates a product_track" do
      assert {:ok, %ProductTrack{} = product_track} = Stock.create_product_track(@valid_attrs)
    end

    test "create_product_track/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stock.create_product_track(@invalid_attrs)
    end

    test "update_product_track/2 with valid data updates the product_track" do
      product_track = product_track_fixture()
      assert {:ok, %ProductTrack{} = product_track} = Stock.update_product_track(product_track, @update_attrs)
    end

    test "update_product_track/2 with invalid data returns error changeset" do
      product_track = product_track_fixture()
      assert {:error, %Ecto.Changeset{}} = Stock.update_product_track(product_track, @invalid_attrs)
      assert product_track == Stock.get_product_track!(product_track.id)
    end

    test "delete_product_track/1 deletes the product_track" do
      product_track = product_track_fixture()
      assert {:ok, %ProductTrack{}} = Stock.delete_product_track(product_track)
      assert_raise Ecto.NoResultsError, fn -> Stock.get_product_track!(product_track.id) end
    end

    test "change_product_track/1 returns a product_track changeset" do
      product_track = product_track_fixture()
      assert %Ecto.Changeset{} = Stock.change_product_track(product_track)
    end
  end
end
