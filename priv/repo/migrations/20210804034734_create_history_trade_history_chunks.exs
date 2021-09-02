defmodule Prop.Repo.Migrations.CreateHistoryTradeHistoryChunks do
  use Ecto.Migration

  def up do
    create table(:trade_history_chunks) do
      add(:venue, :string, null: false)
      add(:product, :string, null: false)
      add(:start_at, :utc_datetime, null: false)
      add(:end_at, :utc_datetime, null: false)
      add(:job_id, references(:trade_history_jobs), null: false)
      add(:status, History.ChunkStatusType.type(), null: false)

      timestamps()
    end

    create(unique_index(:trade_history_chunks, [:venue, :product, :job_id, :start_at, :end_at]))
  end

  def down do
    drop table(:trade_history_chunks)
  end
end
