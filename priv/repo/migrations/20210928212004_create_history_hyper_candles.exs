defmodule Prop.Repo.Migrations.CreateHistoryHyperCandles do
  use Ecto.Migration

  def up do
    # create temp hyper table to migrate existing data
    create table(:hyper_candles, primary_key: false) do
      add :time, :utc_datetime, null: false
      add :venue, :string, null: false
      add :product, :string, null: false
      add :source, :string, null: false
      add :period, History.PeriodType.type(), null: false
      add :open, :decimal, null: false
      add :high, :decimal, null: false
      add :low, :decimal, null: false
      add :close, :decimal, null: false
      add :volume, :decimal, null: false

      timestamps()
    end

    execute "SELECT create_hypertable('hyper_candles', 'time');"

    execute """
    INSERT INTO hyper_candles (
      time,
      venue,
      product,
      source,
      period,
      open,
      high,
      low,
      close,
      volume,
      inserted_at,
      updated_at
    )
    SELECT
      candles.time,
      candles.venue,
      candles.product,
      candles.source,
      candles.period,
      candles.open,
      candles.high,
      candles.low,
      candles.close,
      candles.volume,
      candles.inserted_at,
      candles.updated_at
    FROM candles;
    """

    create unique_index(:hyper_candles, [:product, :period, :venue, :source, :time])

    # create hyper table to migrate data into final form
    drop table(:candles)

    create table(:candles, primary_key: false) do
      add :time, :utc_datetime, null: false
      add :venue, :string, null: false
      add :product, :string, null: false
      add :source, :string, null: false
      add :period, History.PeriodType.type(), null: false
      add :open, :decimal, null: false
      add :high, :decimal, null: false
      add :low, :decimal, null: false
      add :close, :decimal, null: false
      add :volume, :decimal, null: false

      timestamps()
    end

    execute "SELECT create_hypertable('candles', 'time');"

    execute """
    INSERT INTO candles (
      time,
      venue,
      product,
      source,
      period,
      open,
      high,
      low,
      close,
      volume,
      inserted_at,
      updated_at
    )
    SELECT
      hyper_candles.time,
      hyper_candles.venue,
      hyper_candles.product,
      hyper_candles.source,
      hyper_candles.period,
      hyper_candles.open,
      hyper_candles.high,
      hyper_candles.low,
      hyper_candles.close,
      hyper_candles.volume,
      hyper_candles.inserted_at,
      hyper_candles.updated_at
    FROM hyper_candles;
    """

    create unique_index(:candles, [:product, :period, :venue, :source, :time])

    drop table(:hyper_candles)
  end

  def down do
    
  end
end
