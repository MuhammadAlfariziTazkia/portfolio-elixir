defmodule Portfolio.BlogTest do
  use Portfolio.DataCase

  alias Portfolio.Blog

  describe "article_categories" do
    alias Portfolio.Blog.ArticleCategory

    import Portfolio.BlogFixtures

    @invalid_attrs %{color: nil, name_en: nil, name_jp: nil, slug: nil, description_en: nil, description_jp: nil, icon: nil}

    test "list_article_categories/0 returns all article_categories" do
      article_category = article_category_fixture()
      assert Blog.list_article_categories() == [article_category]
    end

    test "get_article_category!/1 returns the article_category with given id" do
      article_category = article_category_fixture()
      assert Blog.get_article_category!(article_category.id) == article_category
    end

    test "create_article_category/1 with valid data creates a article_category" do
      valid_attrs = %{color: "some color", name_en: "some name_en", name_jp: "some name_jp", slug: "some slug", description_en: "some description_en", description_jp: "some description_jp", icon: "some icon"}

      assert {:ok, %ArticleCategory{} = article_category} = Blog.create_article_category(valid_attrs)
      assert article_category.color == "some color"
      assert article_category.name_en == "some name_en"
      assert article_category.name_jp == "some name_jp"
      assert article_category.slug == "some slug"
      assert article_category.description_en == "some description_en"
      assert article_category.description_jp == "some description_jp"
      assert article_category.icon == "some icon"
    end

    test "create_article_category/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_article_category(@invalid_attrs)
    end

    test "update_article_category/2 with valid data updates the article_category" do
      article_category = article_category_fixture()
      update_attrs = %{color: "some updated color", name_en: "some updated name_en", name_jp: "some updated name_jp", slug: "some updated slug", description_en: "some updated description_en", description_jp: "some updated description_jp", icon: "some updated icon"}

      assert {:ok, %ArticleCategory{} = article_category} = Blog.update_article_category(article_category, update_attrs)
      assert article_category.color == "some updated color"
      assert article_category.name_en == "some updated name_en"
      assert article_category.name_jp == "some updated name_jp"
      assert article_category.slug == "some updated slug"
      assert article_category.description_en == "some updated description_en"
      assert article_category.description_jp == "some updated description_jp"
      assert article_category.icon == "some updated icon"
    end

    test "update_article_category/2 with invalid data returns error changeset" do
      article_category = article_category_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_article_category(article_category, @invalid_attrs)
      assert article_category == Blog.get_article_category!(article_category.id)
    end

    test "delete_article_category/1 deletes the article_category" do
      article_category = article_category_fixture()
      assert {:ok, %ArticleCategory{}} = Blog.delete_article_category(article_category)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_article_category!(article_category.id) end
    end

    test "change_article_category/1 returns a article_category changeset" do
      article_category = article_category_fixture()
      assert %Ecto.Changeset{} = Blog.change_article_category(article_category)
    end
  end

  describe "articles" do
    alias Portfolio.Blog.Article

    import Portfolio.BlogFixtures

    @invalid_attrs %{title_en: nil, title_jp: nil, slug: nil, description_en: nil, description_jp: nil, content_en: nil, content_jp: nil, thumbnail: nil, published_date: nil, read_time: nil}

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Blog.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Blog.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      valid_attrs = %{title_en: "some title_en", title_jp: "some title_jp", slug: "some slug", description_en: "some description_en", description_jp: "some description_jp", content_en: "some content_en", content_jp: "some content_jp", thumbnail: "some thumbnail", published_date: ~D[2025-06-11], read_time: 42}

      assert {:ok, %Article{} = article} = Blog.create_article(valid_attrs)
      assert article.title_en == "some title_en"
      assert article.title_jp == "some title_jp"
      assert article.slug == "some slug"
      assert article.description_en == "some description_en"
      assert article.description_jp == "some description_jp"
      assert article.content_en == "some content_en"
      assert article.content_jp == "some content_jp"
      assert article.thumbnail == "some thumbnail"
      assert article.published_date == ~D[2025-06-11]
      assert article.read_time == 42
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      update_attrs = %{title_en: "some updated title_en", title_jp: "some updated title_jp", slug: "some updated slug", description_en: "some updated description_en", description_jp: "some updated description_jp", content_en: "some updated content_en", content_jp: "some updated content_jp", thumbnail: "some updated thumbnail", published_date: ~D[2025-06-12], read_time: 43}

      assert {:ok, %Article{} = article} = Blog.update_article(article, update_attrs)
      assert article.title_en == "some updated title_en"
      assert article.title_jp == "some updated title_jp"
      assert article.slug == "some updated slug"
      assert article.description_en == "some updated description_en"
      assert article.description_jp == "some updated description_jp"
      assert article.content_en == "some updated content_en"
      assert article.content_jp == "some updated content_jp"
      assert article.thumbnail == "some updated thumbnail"
      assert article.published_date == ~D[2025-06-12]
      assert article.read_time == 43
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_article(article, @invalid_attrs)
      assert article == Blog.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Blog.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Blog.change_article(article)
    end
  end
end
