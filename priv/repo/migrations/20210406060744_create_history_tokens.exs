defmodule Prop.Repo.Migrations.CreateHistoryTokens do
  use Ecto.Migration

  def change do
    create table(:tokens) do
      add :name, :string
      add :symbol, :string

      timestamps()
    end

    create unique_index(:tokens, [:name, :symbol])
  end
end
