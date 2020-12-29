# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     StockApi.Repo.insert!(%StockApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias StockApi.Repo
alias StockApi.User
alias StockApi.Stock.Product

Ecto.

Repo.transaction(fn ->
  %User{}
  |> User.changeset(%{
    email: "marcus.golds@hotmail.com",
    email_confirmation: "marcus.golds@hotmail.com",
    full_name: "Marcus Goldschmidt Oliveira",
    phone_number: "5569981687255",
    password: "123456",
    password_confirmation: "123456"
  })
  |> Repo.insert!()

  %Product{}
  |> Product.changeset(%{
    code: "36881",
    description: "Blush Compacto Aquarela Bronze 4",
    suggest_price: 29.8,
    real_price: 19,
    consultant_price: 13.3
  })
  |> Repo.insert!()
  |> Ecto.build_assoc(:product_tracks, %{
    quantity: 5,
    expiration_date: Date.utc_today() |> Date.add(30)
  })
  |> Repo.insert!()
end)
