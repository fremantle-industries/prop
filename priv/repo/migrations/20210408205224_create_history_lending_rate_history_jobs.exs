defmodule Prop.Repo.Migrations.CreateHistoryLendingRateHistoryJobs do
  use Ecto.Migration

  def up do
    create table(:lending_rate_history_jobs) do
      add(:from_date, :date, null: false)
      add(:from_time, :time, null: false)
      add(:to_date, :date, null: false)
      add(:to_time, :time, null: false)
      add(:tokens, {:array, :jsonb}, null: false)
      add(:status, History.JobStatusType.type(), null: false)

      timestamps()
    end
  end

  def down do
    drop table(:lending_rate_history_jobs)
  end
end
