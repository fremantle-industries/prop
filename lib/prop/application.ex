defmodule Prop.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    Confex.resolve_env!(:prop)

    children = [
      Prop.Repo,
      PropWeb.Telemetry,
      PropWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Prop.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PropWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
