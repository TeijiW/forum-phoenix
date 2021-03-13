defmodule Forum.Repo.Migrations.CreateCommentTable do
  use Ecto.Migration

  def change do
    create table(:comment, primary_key: false)do
      add :id, :uuid, primary_key: true
      add :username, :string
      add :message, :text
      add :thread_id, references(:thread, type: :uuid, on_delete: :delete_all)
      timestamps()
    end
  end
end
