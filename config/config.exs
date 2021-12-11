import Config

# Tai can't switch adapters at runtime
config :tai, order_repo_adapter: Ecto.Adapters.Postgres

# Ecto repos must be set at compile time
# config :prop, ecto_repos: [Prop.Repo]
config :prop,
  ecto_repos: [
    Prop.Repo,
    History.Repo,
    Workbench.Repo,
    Tai.Orders.OrderRepo,
    Rube.Repo
  ]

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

# Disable livebook authentication by default
config :livebook, :authentication_mode, :disabled

# A list of custom plugs in the following format:
#
#    [{plug_module :: module(), opts :: keyword()}]
#
# The plugs are called directly before the Livebook router.
config :livebook, :plugs, []

# A list of additional notebooks to include in the Explore sections.
#
# Note that the notebooks are loaded and embedded in a compiled module,
# so the paths are accessed at compile time only.
config :livebook, :explore_notebooks, []
