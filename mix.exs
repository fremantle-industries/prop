defmodule Prop.MixProject do
  use Mix.Project

  def project do
    [
      app: :prop,
      version: "0.0.1",
      elixir: "~> 1.11",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {Prop.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:accessible, "~> 0.3"},
      {:confex, "~> 3.5.0"},
      {:ecto_sql, "~> 3.4"},
      # ex_abi 0.5.3 changes the output decoder which breaks slurp
      # https://github.com/poanetwork/ex_abi/pull/50/files
      {:ex_abi, "0.5.2"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:libcluster, "~> 3.2"},
      {:master_proxy, "~> 0.1"},
      {:navigator, "~> 0.0.4"},
      {:notified_phoenix, "~> 0.0.4"},
      {:phoenix, "~> 1.5"},
      {:phoenix_ecto, "~> 4.1"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_dashboard, "~> 0.4"},
      {:phoenix_live_view, "~> 0.15"},
      {:plug_cowboy, "~> 2.0"},
      {:postgrex, ">= 0.0.0"},
      {:rube, "~> 0.1.0"},
      # {:slurpee, github: "fremantle-industries/slurpee", branch: "main", override: true},
      {:slurpee, "~> 0.0.10"},
      # {:stylish, github: "fremantle-industries/stylish", branch: "main", override: true},
      {:stylish, "~> 0.0.5"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      # {:workbench, "~> 0.0.11"},
      {:workbench, github: "fremantle-industries/workbench", branch: "main", override: true},
      {:excoveralls, "~> 0.8", only: :test},
      {:ex_unit_notifier, "~> 1.0", only: :test},
      {:floki, ">= 0.30.0", only: :test},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:mix_test_watch, "~> 1.0", only: :dev, runtime: false},
      {:phoenix_live_reload, "~> 1.2", only: :dev}
    ]
  end

  defp aliases do
    [
      "setup.deps": ["deps.get", "cmd npm install --prefix assets"],
      setup: ["setup.deps", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
