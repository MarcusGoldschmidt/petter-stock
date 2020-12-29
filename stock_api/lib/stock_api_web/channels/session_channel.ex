defmodule StockApiWeb.SessionChannel do
  use StockApiWeb, :channel
  alias StockApiWeb.AuthHelper
  alias StockApi.Stock.{Product, ProductTrack}
  alias StockApi.Stock
  alias StockApiWeb.Presence

  # TODO: Adicionar multi session
  @impl true
  def join("session:room", %{"token" => token, "userAgent" => user_agent}, socket) do
    with true <- authorized?(token),
         {:ok, claims} <- AuthHelper.get_claims(token) do
      user_data = %{
        user_id: claims["sub"],
        email: claims["email"],
        full_name: claims["fullName"],
        user_agent: user_agent
      }

      assign(socket, :current_user, user_data)

      send(self(), {:after_join, user_data})

      {:ok, socket}
    else
      _ -> {:error, %{reason: "unauthorized"}}
    end
  end

  @impl true
  def handle_info({:after_join, user_data}, socket) do
    {:ok, _} = Presence.track(socket, socket.assigns["user_id"], user_data)

    push(socket, "presence_state", Presence.list(socket))

    {:noreply, socket}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (product:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  @impl true
  def handle_in("verify_barcode", payload, socket) do
    case Stock.get_by_barcode(payload.barcode) do
      %Product{} = product -> {:reply, {:ok, product}, socket}
      _ -> {:reply, {:error, nil}, socket}
    end
  end

  @impl true
  def handle_in("add_product_track", payload, socket) do
    case Stock.create_product_track(payload) do
      %ProductTrack{} = product ->
        broadcast(socket, "add_product_track", product)
        {:reply, {:ok, product}, socket}

      _ ->
        {:reply, {:error, nil}, socket}
    end
  end

  @impl true
  def handle_in("remove_product_track", %{"id" => id}, socket) do
    case Stock.get_product_track!(id) |> Stock.delete_product_track() do
      {:ok, product} ->
        broadcast(socket, "remove_product_track", product)
        {:reply, {:ok, product}, socket}

      _ ->
        {:reply, {false, nil}, socket}
    end
  end

  # Add authorization logic here as required.
  defp authorized?(token) do
    AuthHelper.authorized?(token)
  end
end
