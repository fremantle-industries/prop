defmodule Prop.Repo.Migrations.CreateHistoryCandles do
  use Ecto.Migration

  def change do
    create table(:candles) do
      add :venue, :string, null: false
      add :product, :string, null: false
      add :source, :string, null: false
      add :period, History.PeriodType.type(), null: false
      add :time, :utc_datetime, null: false
      add :open, :decimal, null: false
      add :high, :decimal, null: false
      add :low, :decimal, null: false
      add :close, :decimal, null: false
      add :volume, :decimal, null: false

      timestamps()
    end

    create unique_index(:candles, [:product, :period, :venue, :source, :time])
  end
end
