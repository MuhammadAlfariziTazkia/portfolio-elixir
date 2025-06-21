defmodule Portfolio.Repo.Migrations.CreateEducation do
  use Ecto.Migration

  def change do
    create table(:education) do
      add :institution_name, :string
      add :degree_en, :string
      add :degree_jp, :string
      add :period, :string
      add :gpa, :string
      add :description_en, :text
      add :description_jp, :text
      add :certificate_url, :string
      add :transcript_url, :string
      add :icon, :string

      timestamps(type: :utc_datetime)
    end
  end
end
