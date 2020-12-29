defmodule StockApiWeb.Router do
  use StockApiWeb, :router
  alias StockApiWeb.Guardian

  pipeline :api do
    plug :accepts, ["json"]
    plug ProperCase.Plug.SnakeCaseParams
  end

  pipeline :auth do
    plug :authenticate
  end

  scope "/", StockApiWeb do
    pipe_through :api

    get "/", DefaultController, :index
  end

  scope "/api", StockApiWeb do
    pipe_through :api

    post "/auth/login", AuthController, :login
    post "/auth/refresh-token", AuthController, :refresh_token
  end

  scope "/api", StockApiWeb do
    pipe_through :api
    pipe_through :auth

    post "/auth/check-user", AuthController, :check_user

    resources "/users", UserController
    resources "/orders", OrderController
    resources "/orders/products", OrderProductController

    resources "/stocks/products", ProductController
    post "/stocks/products/image", ProductController, :image_upload
    resources "/stocks/products/track", ProductTrackController
  end

  defp authenticate(conn, _) do
    token =
      conn.req_headers
      |> Enum.find_value("", fn {key, v} -> if key == "authorization", do: v end)
      |> String.split(" ")
      |> List.last() || ""

    case Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        assign(conn, :claims, claims)

      {:error, _} ->
        conn |> send_resp(401, "") |> halt()
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: StockApiWeb.Telemetry
    end
  end
end
