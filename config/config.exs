import Config

# Ecto repos must be set at compile time
config :prop, ecto_repos: [Prop.Repo, Workbench.Repo, Tai.NewOrders.OrderRepo, Rube.Repo]

# Tai must set order repo adapter at compile time
config :tai, order_repo_adapter: Ecto.Adapters.Postgres

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
