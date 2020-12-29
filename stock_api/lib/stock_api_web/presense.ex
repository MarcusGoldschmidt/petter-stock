defmodule StockApiWeb.Presence do
  use Phoenix.Presence,
    otp_app: :stock_api,
    pubsub_server: StockApi.PubSub
end
