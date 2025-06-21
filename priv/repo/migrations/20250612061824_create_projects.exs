defmodule Portfolio.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :title, :string
      add :role_en, :string
      add :role_jp, :string
      add :description_en, :text
      add :description_jp, :text
      add :project_url, :string
      add :is_public, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
