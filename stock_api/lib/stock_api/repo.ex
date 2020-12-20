defmodule StockApi.Repo do
  use Ecto.Repo,
    otp_app: :stock_api,
    adapter: Ecto.Adapters.Postgres
end
