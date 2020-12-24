defmodule StockApiWeb.Api.UserController do
  use StockApiWeb, :controller
  alias StockApi.{Repo, User}
  alias StockApiWeb.ResponseHelper

  def index(conn, _params) do
    users = Repo.all(User)

    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render(conn, "show.json", user: user)
  end

  def create(conn, params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
    |> ResponseHelper.ecto_map(conn, fn data -> render(conn, "user.json", user: data) end)
  end

  def edit(conn, _params) do
    users = Repo.all(User)

    render(conn, "user.json", users: users)
  end

  def delete(conn, _params) do
    users = Repo.all(User)

    render(conn, "user.json", users: users)
  end
end
