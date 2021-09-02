defmodule Prop.Repo.Migrations.CreateHistoryCandleHistoryChunks do
  use Ecto.Migration

  def up do
    create table(:candle_history_chunks) do
      add(:job_id, references(:candle_history_jobs), null: false)
      add(:venue, :string, null: false)
      add(:product, :string, null: false)
      add(:start_at, :utc_datetime, null: false)
      add(:end_at, :utc_datetime, null: false)
      add(:period, History.PeriodType.type(), null: false)
      add(:status, History.ChunkStatusType.type(), null: false)

      timestamps()
    end

    create(
      unique_index(:candle_history_chunks, [:venue, :product, :job_id, :start_at, :end_at, :period])
    )
  end

  def down do
    drop table(:candle_history_chunks)
  end
end
