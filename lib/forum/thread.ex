defmodule Forum.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  alias Forum.Comment

  schema "thread" do
    field :username, :string
    field :title, :string
    field :description, :string
    has_many(:comments, Comment, foreign_key: :thread_id)
    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  @required_params [:username, :title, :description]
  def changeset(params), do: create_changeset(%__MODULE__{}, params)
  def changeset(thread, params), do: create_changeset(thread, params)

  defp create_changeset(thread_or_module, params) do
    thread_or_module
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:title, min: 3, max: 255)
    |> validate_length(:description, min: 3)
    |> validate_length(:username, min: 3, max: 255)
  end
end
