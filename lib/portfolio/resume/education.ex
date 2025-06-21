defmodule Portfolio.Resume.Education do
  use Ecto.Schema
  import Ecto.Changeset

  schema "education" do
    field :period, :string
    field :institution_name, :string
    field :degree_en, :string
    field :degree_jp, :string
    field :gpa, :string
    field :description_en, :string
    field :description_jp, :string
    field :certificate_url, :string
    field :transcript_url, :string
    field :icon, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(education, attrs) do
    education
    |> cast(attrs, [:institution_name, :degree_en, :degree_jp, :period, :gpa, :description_en, :description_jp, :certificate_url, :transcript_url, :icon])
    |> validate_required([:institution_name, :degree_en, :degree_jp, :period, :gpa, :description_en, :description_jp, :certificate_url, :transcript_url, :icon])
  end
end
