defmodule Prop.Repo.Migrations.RemoveHistoryDeltaAndSourceAndTimestampsFromCandles do
  use Ecto.Migration

  def up do
    drop index(:candles, [:product, :period, :venue, :source, :time])

    alter table(:candles) do
      remove :source
      remove :inserted_at
      remove :updated_at
      remove :delta_high
      remove :delta_low
      remove :delta_close
    end

    create unique_index(:candles, [:product, :period, :venue, :time])
  end

  def down do
    drop index(:candles, [:product, :period, :venue, :time])

    alter table(:candles) do
      add :source, :string
      add :inserted_at, :timestamp
      add :updated_at, :timestamp
      add :delta_high, :decimal
      add :delta_low, :decimal
      add :delta_close, :decimal
    end

    execute """
    UPDATE candles
    SET
      source = 'api',
      inserted_at = NOW(),
      updated_at = NOW(),
      delta_high = (high - open) / open,
      delta_low = (low - open) / open,
      delta_close = (close - open) / open
    """

    alter table(:candles) do
      modify :source, :string, null: false
      modify :inserted_at, :string, null: false
      modify :updated_at, :string, null: false
      modify :delta_high, :decimal, null: false
      modify :delta_low, :decimal, null: false
      modify :delta_close, :decimal, null: false
    end

    create unique_index(:candles, [:product, :period, :venue, :source, :time])
  end
end
