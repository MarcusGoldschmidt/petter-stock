defmodule StockApiWeb.UserView do
  use StockApiWeb, :view

  def render("index.json", %{users: users}) do
    render_many(users, StockApiWeb.Api.UserView, "show.json")
  end

  def render("show.json", %{user: user}) do
    render_one(user, StockApiWeb.Api.UserView, "user.json")
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      fullName: user.full_name,
      email: user.email,
      phoneNumber: user.phone_number
    }
  end
end
