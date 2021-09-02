defmodule Prop.Repo.Migrations.CreateHistoryTrades do
  use Ecto.Migration

  def up do
    create table(:trades) do
      add(:time, :utc_datetime, null: false)
      add(:venue, :string, null: false)
      add(:product, :string, null: false)
      add(:venue_order_id, :string, null: false)
      add(:side, :string, null: false)
      add(:price, :decimal, null: false)
      add(:qty, :decimal, null: false)
      add(:liquidation, :boolean)
      add(:source, :string, null: false)

      timestamps()
    end

    create unique_index(:trades, [:time, :venue, :product, :source])
  end

  def down do
    drop table(:trades)
  end
end
