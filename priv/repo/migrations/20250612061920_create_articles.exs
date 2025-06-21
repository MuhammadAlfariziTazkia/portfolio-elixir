defmodule Portfolio.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title_en, :string
      add :title_jp, :string
      add :slug, :string
      add :description_en, :text
      add :description_jp, :text
      add :content_en, :text
      add :content_jp, :text
      add :thumbnail, :string
      add :published_date, :date
      add :read_time, :integer
      add :category_id, references(:article_categories, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:articles, [:category_id])
  end
end
