defmodule Portfolio.Blog.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :title_en, :string
    field :title_jp, :string
    field :slug, :string
    field :description_en, :string
    field :description_jp, :string
    field :content_en, :string
    field :content_jp, :string
    field :thumbnail, :string
    field :published_date, :date
    field :read_time, :integer

    belongs_to :category, Portfolio.Blog.ArticleCategor, foreign_key: :category_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:title_en, :title_jp, :slug, :description_en, :description_jp, :content_en, :content_jp, :thumbnail, :published_date, :read_time, :category_id])
    |> validate_required([:title_en, :title_jp, :slug, :description_en, :description_jp, :content_en, :content_jp, :thumbnail, :published_date, :read_time, :category_id])
    |> foreign_key_constraint(:category_id)
  end
end
