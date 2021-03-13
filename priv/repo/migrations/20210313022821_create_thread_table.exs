defmodule Forum.Repo.Migrations.CreateThreadTable do
  use Ecto.Migration

  def change do
    create table(:thread, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :description, :text
      timestamps()
    end
  end
end
