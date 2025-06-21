defmodule Portfolio.Resume.WorkExperience do
  use Ecto.Schema
  import Ecto.Changeset

  schema "work_experiences" do
    field :period, :string
    field :company, :string
    field :position_en, :string
    field :position_jp, :string
    field :type_en, :string
    field :type_jp, :string
    field :logo, :string
    field :description_en, :string
    field :description_jp, :string
    field :key_achievements_en, :string
    field :key_achievements_jp, :string
    field :full_description_en, :string
    field :full_description_jp, :string
    field :detailed_achievements_en, :string
    field :detailed_achievements_jp, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(work_experience, attrs) do
    work_experience
    |> cast(attrs, [:company, :position_en, :position_jp, :period, :type_en, :type_jp, :logo, :description_en, :description_jp, :key_achievements_en, :key_achievements_jp, :full_description_en, :full_description_jp, :detailed_achievements_en, :detailed_achievements_jp])
    |> validate_required([:company, :position_en, :position_jp, :period, :type_en, :type_jp, :logo, :description_en, :description_jp, :key_achievements_en, :key_achievements_jp, :full_description_en, :full_description_jp, :detailed_achievements_en, :detailed_achievements_jp])
  end
end
