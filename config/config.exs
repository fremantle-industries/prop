import Config

# Ecto repos must be set at compile time
config :prop, ecto_repos: [Prop.Repo, Workbench.Repo, Tai.NewOrders.OrderRepo, Rube.Repo]

# Tai must set order repo adapter at compile time
config :tai, order_repo_adapter: Ecto.Adapters.Postgres

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Sets the default runtime to ElixirStandalone.
# This is the desired default most of the time,
# but in some specific use cases you may want
# to configure that to the Embedded or Mix runtime instead.
# Also make sure the configured runtime has
# a synchronous `init` function that takes the
# configured arguments.
config :livebook, :default_runtime, {Livebook.Runtime.ElixirStandalone, []}
