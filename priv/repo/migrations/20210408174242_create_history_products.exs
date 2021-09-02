defmodule Prop.Repo.Migrations.CreateHistoryProducts do
  use Ecto.Migration

  def up do
    History.ProductType.create_type()

    create table(:products) do
      add(:venue, :string, null: false)
      add(:symbol, :string, null: false)
      add(:venue_symbol, :string, null: false)
      add(:base, :string, null: false)
      add(:quote, :string, null: false)
      add(:type, History.ProductType.type(), null: false)

      timestamps()
    end

    create(unique_index(:products, [:venue, :symbol, :type]))
  end

  def down do
    drop table(:products)
    History.ProductType.drop_type()
  end
end
