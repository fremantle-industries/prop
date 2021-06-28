defmodule Prop.Repo do
  use Ecto.Repo,
    otp_app: :prop,
    adapter: Ecto.Adapters.Postgres
end
