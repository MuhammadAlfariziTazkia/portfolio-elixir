defmodule Portfolio.Resume.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :title, :string
    field :role_en, :string
    field :role_jp, :string
    field :description_en, :string
    field :description_jp, :string
    field :project_url, :string
    field :is_public, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:title, :role_en, :role_jp, :description_en, :description_jp, :project_url, :is_public])
    |> validate_required([:title, :role_en, :role_jp, :description_en, :description_jp, :project_url, :is_public])
  end
end
