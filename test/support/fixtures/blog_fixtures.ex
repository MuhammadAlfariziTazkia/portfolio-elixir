defmodule Portfolio.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Portfolio.Blog` context.
  """

  @doc """
  Generate a article_category.
  """
  def article_category_fixture(attrs \\ %{}) do
    {:ok, article_category} =
      attrs
      |> Enum.into(%{
        color: "some color",
        description_en: "some description_en",
        description_jp: "some description_jp",
        icon: "some icon",
        name_en: "some name_en",
        name_jp: "some name_jp",
        slug: "some slug"
      })
      |> Portfolio.Blog.create_article_category()

    article_category
  end

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        content_en: "some content_en",
        content_jp: "some content_jp",
        description_en: "some description_en",
        description_jp: "some description_jp",
        published_date: ~D[2025-06-11],
        read_time: 42,
        slug: "some slug",
        thumbnail: "some thumbnail",
        title_en: "some title_en",
        title_jp: "some title_jp"
      })
      |> Portfolio.Blog.create_article()

    article
  end
end
