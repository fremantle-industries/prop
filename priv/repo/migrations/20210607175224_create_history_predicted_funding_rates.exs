defmodule Prop.Repo.Migrations.CreateHistoryPredictedFundingRates do
  use Ecto.Migration

  def change do
    create table(:predicted_funding_rates) do
      add :next_funding_time, :utc_datetime, null: false
      add :venue, :string, null: false
      add :product, :string, null: false
      add :next_funding_rate, :decimal, null: false

      timestamps()
    end

    create unique_index(:predicted_funding_rates, [:next_funding_time, :venue, :product])
  end
end
