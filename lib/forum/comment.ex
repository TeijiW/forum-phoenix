defmodule Forum.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Forum.Thread

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "comment" do
    field :username, :string
    field :message, :string
    belongs_to(:thread, Thread)
    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  @required_params [:username, :message, :thread_id]

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> cast_assoc(:thread)
    |> foreign_key_constraint(:thread_id)
    |> validate_required(@required_params)
    |> validate_length(:username, max: 255)
  end
end
