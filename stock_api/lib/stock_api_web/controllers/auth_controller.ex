defmodule StockApiWeb.AuthController do
  use StockApiWeb, :controller
  import Ecto.Query

  alias StockApi.{Repo, User}
  alias StockApiWeb.{Guardian, GuardianRefresh}

  def login(conn, %{"email" => email, "password" => password}) do
    with user <- from(User, where: [email: ^email]) |> Repo.one(),
         true <- Argon2.verify_pass(password, user.password_hash) do
      json(conn, create_jwt_and_refresh_token(user))
    else
      _ ->
        conn
        |> put_status(401)
        |> json(%{})
    end
  end

  def refresh_token(conn, %{"refresh_token" => refresh_token}) do
    case GuardianRefresh.decode_and_verify(refresh_token) do
      {:ok, claims} ->
        {:ok, user} = GuardianRefresh.resource_from_claims(claims)
        json(conn, create_jwt_and_refresh_token(user))

      {:error, _} ->
        conn
        |> put_status(401)
        |> json(%{})
    end
  end

  def check_user(conn, _params) do
    token =
      conn.req_headers
      |> Enum.find_value("", fn {key, v} -> if key == "authorization", do: v end)
      |> String.split(" ")
      |> List.last() || ""

    case Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        json(conn, %{
          fullName: claims["fullName"],
          id: claims["sub"],
          email: claims["email"]
        })

      {:error, _} ->
        conn
        |> put_status(401)
        |> json(%{})
    end
  end

  defp create_jwt_and_refresh_token(%User{} = user) do
    with {:ok, token, _} <-
           Guardian.encode_and_sign(user, %{email: user.email, fullName: user.full_name}),
         {:ok, refresh_token, _} <- GuardianRefresh.encode_and_sign(user) do
      %{
        name: user.full_name,
        email: user.email,
        tokens: %{
          token: token,
          refreshToken: refresh_token
        }
      }
    end
  end
end
