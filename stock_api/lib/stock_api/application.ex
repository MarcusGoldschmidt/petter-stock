defmodule StockApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      StockApi.Repo,
      # Start the Telemetry supervisor
      StockApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: StockApi.PubSub},
      StockApiWeb.Presence,
      # Start the Endpoint (http/https)
      StockApiWeb.Endpoint
      # Start a worker by calling: StockApi.Worker.start_link(arg)
      # {StockApi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StockApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    StockApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
