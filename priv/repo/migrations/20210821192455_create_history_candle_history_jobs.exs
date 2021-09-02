defmodule Prop.Repo.Migrations.CreateHistoryCandleHistoryJobs do
  use Ecto.Migration

  def up do
    create table(:candle_history_jobs) do
      add(:from_date, :date, null: false)
      add(:from_time, :time, null: false)
      add(:to_date, :date, null: false)
      add(:to_time, :time, null: false)
      add(:products, {:array, :jsonb}, null: false)
      add(:periods, {:array, History.PeriodType.type()}, null: false)
      add(:status, History.JobStatusType.type(), null: false)

      timestamps()
    end
  end

  def down do
    drop table(:candle_history_jobs)
  end
end
