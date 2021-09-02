defmodule Prop.Repo.Migrations.CreateHistoryPredictedFundingRateChunks do
  use Ecto.Migration

  def up do
    create table(:predicted_funding_rate_chunks) do
      add(:venue, :string, null: false)
      add(:product, :string, null: false)
      add(:job_id, references(:predicted_funding_rate_jobs), null: false)
      add(:status, History.ChunkStatusType.type(), null: false)

      timestamps()
    end

    create(unique_index(:predicted_funding_rate_chunks, [:venue, :product, :job_id]))
  end

  def down do
    drop table(:predicted_funding_rate_chunks)
  end
end
