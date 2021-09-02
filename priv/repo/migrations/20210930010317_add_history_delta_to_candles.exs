defmodule Prop.Repo.Migrations.AddHistoryDeltaToCandles do
  use Ecto.Migration

  def up do
    alter table(:candles) do
      add :delta_high, :decimal
      add :delta_low, :decimal
      add :delta_close, :decimal
    end

    execute """
    UPDATE candles
    SET
      delta_high = (high - open) / open,
      delta_low = (low - open) / open,
      delta_close = (close - open) / open
    """

    alter table(:candles) do
      modify :delta_high, :decimal, null: false
      modify :delta_low, :decimal, null: false
      modify :delta_close, :decimal, null: false
    end
  end

  def down do
    alter table(:candles) do
      remove :delta_high
      remove :delta_low
      remove :delta_close
    end
  end
end
