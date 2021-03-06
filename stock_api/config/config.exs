# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :stock_api,
  ecto_repos: [StockApi.Repo]

config :stock_api, StockApiWeb.Gettext, default_locale: "pt_BR"

# Guardian config
config :stock_api, StockApiWeb.Guardian,
  issuer: "petter-stock",
  # Use `mix guardian.gen.secret` to generate one
  secret_key: "a3V/mDp7VhjYr5pLrjyJsQ0QQRR9x7DJPESjjPnMt/q2U72H8955Jrcve+3POZqQ",
  ttl: {1, :day}

config :stock_api, StockApiWeb.GuardianRefresh,
  issuer: "petter-stock",
  # Use `mix guardian.gen.secret` to generate one
  secret_key: "a3V/mDp7VhjYr5pLrjyJsQ0QQRR9x7DJPESjjPnMt/q2U72H8955Jrcve+3POZqQ",
  ttl: {7, :day}

# Configures the endpoint
config :stock_api, StockApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JrruJ6DY639D/bUgzJSgwJdJEUy/79unoTdIVwgTwT+vPABgxqN3iE/cJgbu4KZY",
  render_errors: [view: StockApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: StockApi.PubSub,
  live_view: [signing_salt: "rGEexuEB"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
