defmodule Prop.MixProject do
  use Mix.Project

  def project do
    [
      app: :prop,
      version: "0.0.4",
      elixir: "~> 1.12",
      package: package(),
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      description: description(),
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
      {:broadway_dashboard, "~> 0.1"},
      {:confex, "~> 3.5.0"},
      {:ecto_sql, "~> 3.4"},
      {:gettext, "~> 0.11"},
      {:history, "~> 0.0.10"},
      {:jason, "~> 1.0"},
      {:libcluster, "~> 3.2"},
      {:livebook, "~> 0.2"},
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
      {:rube, "~> 0.0.3"},
      # {:slurpee, github: "fremantle-industries/slurpee", branch: "main", override: true},
      {:slurpee, "~> 0.0.11"},
      # {:stylish, github: "fremantle-industries/stylish", branch: "main", override: true},
      {:stylish, "~> 0.0.5"},
      {:tai, "~> 0.0.69"},
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},
      # {:workbench, github: "fremantle-industries/workbench", branch: "main", override: true},
      {:workbench, "~> 0.0.13"},
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
      setup: ["setup.deps", "setup.tai", "setup.workbench", "setup.history", "ecto.setup"],
      "setup.deps": ["deps.get", "cmd npm install --prefix assets"],
      "setup.tai": ["tai.gen.migration"],
      "setup.workbench": ["workbench.gen.migration"],
      "setup.history": ["history.gen.migration"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end

  defp description do
    "An open and opinionated DeFi/CeFi/TradFi trading platform using productive & familiar open source libraries and tools for strategy research, execution and operation"
  end

  defp package do
    %{
      licenses: ["MIT"],
      maintainers: ["Alex Kwiatkowski"],
      links: %{"GitHub" => "https://github.com/fremantle-industries/prop"}
    }
  end
end
