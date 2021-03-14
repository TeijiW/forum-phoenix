defmodule Forum.Repo.Migrations.CreateThreadTable do
  use Ecto.Migration

  def change do
    create table(:thread) do
      add :title, :string
      add :description, :text
      timestamps()
    end
  end
end
