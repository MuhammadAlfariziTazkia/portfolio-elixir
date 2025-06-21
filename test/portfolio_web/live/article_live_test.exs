defmodule PortfolioWeb.ArticleLiveTest do
  use PortfolioWeb.ConnCase

  import Phoenix.LiveViewTest
  import Portfolio.BlogFixtures

  @create_attrs %{title_en: "some title_en", title_jp: "some title_jp", slug: "some slug", description_en: "some description_en", description_jp: "some description_jp", content_en: "some content_en", content_jp: "some content_jp", thumbnail: "some thumbnail", published_date: "2025-06-11", read_time: 42}
  @update_attrs %{title_en: "some updated title_en", title_jp: "some updated title_jp", slug: "some updated slug", description_en: "some updated description_en", description_jp: "some updated description_jp", content_en: "some updated content_en", content_jp: "some updated content_jp", thumbnail: "some updated thumbnail", published_date: "2025-06-12", read_time: 43}
  @invalid_attrs %{title_en: nil, title_jp: nil, slug: nil, description_en: nil, description_jp: nil, content_en: nil, content_jp: nil, thumbnail: nil, published_date: nil, read_time: nil}

  defp create_article(_) do
    article = article_fixture()
    %{article: article}
  end

  describe "Index" do
    setup [:create_article]

    test "lists all articles", %{conn: conn, article: article} do
      {:ok, _index_live, html} = live(conn, ~p"/articles")

      assert html =~ "Listing Articles"
      assert html =~ article.title_en
    end

    test "saves new article", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/articles")

      assert index_live |> element("a", "New Article") |> render_click() =~
               "New Article"

      assert_patch(index_live, ~p"/articles/new")

      assert index_live
             |> form("#article-form", article: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#article-form", article: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/articles")

      html = render(index_live)
      assert html =~ "Article created successfully"
      assert html =~ "some title_en"
    end

    test "updates article in listing", %{conn: conn, article: article} do
      {:ok, index_live, _html} = live(conn, ~p"/articles")

      assert index_live |> element("#articles-#{article.id} a", "Edit") |> render_click() =~
               "Edit Article"

      assert_patch(index_live, ~p"/articles/#{article}/edit")

      assert index_live
             |> form("#article-form", article: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#article-form", article: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/articles")

      html = render(index_live)
      assert html =~ "Article updated successfully"
      assert html =~ "some updated title_en"
    end

    test "deletes article in listing", %{conn: conn, article: article} do
      {:ok, index_live, _html} = live(conn, ~p"/articles")

      assert index_live |> element("#articles-#{article.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#articles-#{article.id}")
    end
  end

  describe "Show" do
    setup [:create_article]

    test "displays article", %{conn: conn, article: article} do
      {:ok, _show_live, html} = live(conn, ~p"/articles/#{article}")

      assert html =~ "Show Article"
      assert html =~ article.title_en
    end

    test "updates article within modal", %{conn: conn, article: article} do
      {:ok, show_live, _html} = live(conn, ~p"/articles/#{article}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Article"

      assert_patch(show_live, ~p"/articles/#{article}/show/edit")

      assert show_live
             |> form("#article-form", article: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#article-form", article: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/articles/#{article}")

      html = render(show_live)
      assert html =~ "Article updated successfully"
      assert html =~ "some updated title_en"
    end
  end
end
