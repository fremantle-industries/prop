defmodule Prop.Repo.Migrations.CreateHistoryJobAndChunkStatusType do
  use Ecto.Migration

  def up do
    History.JobStatusType.create_type()
    History.ChunkStatusType.create_type()
  end

  def down do
    History.JobStatusType.drop_type()
    History.ChunkStatusType.drop_type()
  end
end
