defmodule Portfolio.Repo.Migrations.CreateArticleCategories do
  use Ecto.Migration

  def change do
    create table(:article_categories) do
      add :name_en, :string
      add :name_jp, :string
      add :slug, :string
      add :description_en, :text
      add :description_jp, :text
      add :icon, :string
      add :color, :string

      timestamps(type: :utc_datetime)
    end
  end
end
