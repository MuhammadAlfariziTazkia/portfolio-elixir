defmodule Portfolio.Blog.ArticleCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "article_categories" do
    field :color, :string
    field :name_en, :string
    field :name_jp, :string
    field :slug, :string
    field :description_en, :string
    field :description_jp, :string
    field :icon, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(article_category, attrs) do
    article_category
    |> cast(attrs, [:name_en, :name_jp, :slug, :description_en, :description_jp, :icon, :color])
    |> validate_required([:name_en, :name_jp, :slug, :description_en, :description_jp, :icon, :color])
  end
end
