defmodule StockApi.OrderRequestTest do
  use StockApi.DataCase

  alias StockApi.OrderRequest

  describe "orders" do
    alias StockApi.OrderRequest.Order

    @valid_attrs %{number: "some number", period: "some period"}
    @update_attrs %{number: "some updated number", period: "some updated period"}
    @invalid_attrs %{number: nil, period: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> OrderRequest.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert OrderRequest.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert OrderRequest.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = OrderRequest.create_order(@valid_attrs)
      assert order.number == "some number"
      assert order.period == "some period"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OrderRequest.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = OrderRequest.update_order(order, @update_attrs)
      assert order.number == "some updated number"
      assert order.period == "some updated period"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = OrderRequest.update_order(order, @invalid_attrs)
      assert order == OrderRequest.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = OrderRequest.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> OrderRequest.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = OrderRequest.change_order(order)
    end
  end

  describe "order_products" do
    alias StockApi.OrderRequest.OrderProduct

    @valid_attrs %{consultant_price: "120.5", delivered_at: ~D[2010-04-17], description: "some description", observation: "some observation", quantity: 42, real_price: "120.5", suggest_price: "120.5"}
    @update_attrs %{consultant_price: "456.7", delivered_at: ~D[2011-05-18], description: "some updated description", observation: "some updated observation", quantity: 43, real_price: "456.7", suggest_price: "456.7"}
    @invalid_attrs %{consultant_price: nil, delivered_at: nil, description: nil, observation: nil, quantity: nil, real_price: nil, suggest_price: nil}

    def order_product_fixture(attrs \\ %{}) do
      {:ok, order_product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> OrderRequest.create_order_product()

      order_product
    end

    test "list_order_products/0 returns all order_products" do
      order_product = order_product_fixture()
      assert OrderRequest.list_order_products() == [order_product]
    end

    test "get_order_product!/1 returns the order_product with given id" do
      order_product = order_product_fixture()
      assert OrderRequest.get_order_product!(order_product.id) == order_product
    end

    test "create_order_product/1 with valid data creates a order_product" do
      assert {:ok, %OrderProduct{} = order_product} = OrderRequest.create_order_product(@valid_attrs)
      assert order_product.consultant_price == Decimal.new("120.5")
      assert order_product.delivered_at == ~D[2010-04-17]
      assert order_product.description == "some description"
      assert order_product.observation == "some observation"
      assert order_product.quantity == 42
      assert order_product.real_price == Decimal.new("120.5")
      assert order_product.suggest_price == Decimal.new("120.5")
    end

    test "create_order_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OrderRequest.create_order_product(@invalid_attrs)
    end

    test "update_order_product/2 with valid data updates the order_product" do
      order_product = order_product_fixture()
      assert {:ok, %OrderProduct{} = order_product} = OrderRequest.update_order_product(order_product, @update_attrs)
      assert order_product.consultant_price == Decimal.new("456.7")
      assert order_product.delivered_at == ~D[2011-05-18]
      assert order_product.description == "some updated description"
      assert order_product.observation == "some updated observation"
      assert order_product.quantity == 43
      assert order_product.real_price == Decimal.new("456.7")
      assert order_product.suggest_price == Decimal.new("456.7")
    end

    test "update_order_product/2 with invalid data returns error changeset" do
      order_product = order_product_fixture()
      assert {:error, %Ecto.Changeset{}} = OrderRequest.update_order_product(order_product, @invalid_attrs)
      assert order_product == OrderRequest.get_order_product!(order_product.id)
    end

    test "delete_order_product/1 deletes the order_product" do
      order_product = order_product_fixture()
      assert {:ok, %OrderProduct{}} = OrderRequest.delete_order_product(order_product)
      assert_raise Ecto.NoResultsError, fn -> OrderRequest.get_order_product!(order_product.id) end
    end

    test "change_order_product/1 returns a order_product changeset" do
      order_product = order_product_fixture()
      assert %Ecto.Changeset{} = OrderRequest.change_order_product(order_product)
    end
  end
end
