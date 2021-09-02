defmodule Prop.Repo.Migrations.CreateHistoryLendingRates do
  use Ecto.Migration

  def change do
    create table(:lending_rates) do
      add :time, :utc_datetime, null: false
      add :venue, :string, null: false
      add :token, :string, null: false
      add :base, :string, null: false
      add :quote, :string, null: false
      add :rate, :decimal, null: false

      timestamps()
    end

    create unique_index(:lending_rates, [:time, :venue, :token])
  end
end
