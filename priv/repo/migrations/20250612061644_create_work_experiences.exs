defmodule Portfolio.Repo.Migrations.CreateWorkExperiences do
  use Ecto.Migration

  def change do
    create table(:work_experiences) do
      add :company, :string
      add :position_en, :string
      add :position_jp, :string
      add :period, :string
      add :type_en, :string
      add :type_jp, :string
      add :logo, :string
      add :description_en, :text
      add :description_jp, :text
      add :key_achievements_en, :text
      add :key_achievements_jp, :text
      add :full_description_en, :text
      add :full_description_jp, :text
      add :detailed_achievements_en, :text
      add :detailed_achievements_jp, :text

      timestamps(type: :utc_datetime)
    end
  end
end
