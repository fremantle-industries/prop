# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
# use Mix.Config

# config :prop,
#   ecto_repos: [Prop.Repo]

# # Configures the endpoint
# config :prop, PropWeb.Endpoint,
#   url: [host: "localhost"],
#   secret_key_base: "uwi9NZNbqTE1Nnro1FvaeKNeFfTWKphLG9IamO4jGLjvNbWhhp10ewNx1I8zPJ/y",
#   render_errors: [view: PropWeb.ErrorView, accepts: ~w(html json), layout: false],
#   pubsub_server: Prop.PubSub,
#   live_view: [signing_salt: "cvulB0bl"]

# # Configures Elixir's Logger
# config :logger, :console,
#   format: "$time $metadata[$level] $message\n",
#   metadata: [:request_id]

# # Use Jason for JSON parsing in Phoenix
# config :phoenix, :json_library, Jason

# # Import environment specific config. This must remain at the bottom
# # of this file so it overrides the configuration defined above.
# import_config "#{Mix.env()}.exs"

import Config

# Ecto repos must be set at compile time
config :prop, ecto_repos: [Prop.Repo, Workbench.Repo, Tai.NewOrders.OrderRepo, Rube.Repo]

# Tai must set order repo adapter at compile time
config :tai, order_repo_adapter: Ecto.Adapters.Postgres

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
