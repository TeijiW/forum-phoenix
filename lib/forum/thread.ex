defmodule Forum.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "thread" do
    field :title, :string
    field :description, :string
    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  @required_params [:title, :description]
  def changeset(params), do: create_changeset(%__MODULE__{}, params)
  def changeset(thread, params), do: create_changeset(thread, params)

  defp create_changeset(thread_or_module, params) do
    thread_or_module
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:title, max: 255)
  end
end
