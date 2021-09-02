defmodule Prop.Repo.Migrations.CreateHistoryFundingRates do
  use Ecto.Migration

  def change do
    create table(:funding_rates) do
      add :time, :utc_datetime, null: false
      add :venue, :string, null: false
      add :product, :string, null: false
      add :rate, :decimal, null: false

      timestamps()
    end

    create unique_index(:funding_rates, [:time, :venue, :product])
  end
end
