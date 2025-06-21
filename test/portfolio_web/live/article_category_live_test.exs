defmodule PortfolioWeb.ArticleCategoryLiveTest do
  use PortfolioWeb.ConnCase

  import Phoenix.LiveViewTest
  import Portfolio.BlogFixtures

  @create_attrs %{color: "some color", name_en: "some name_en", name_jp: "some name_jp", slug: "some slug", description_en: "some description_en", description_jp: "some description_jp", icon: "some icon"}
  @update_attrs %{color: "some updated color", name_en: "some updated name_en", name_jp: "some updated name_jp", slug: "some updated slug", description_en: "some updated description_en", description_jp: "some updated description_jp", icon: "some updated icon"}
  @invalid_attrs %{color: nil, name_en: nil, name_jp: nil, slug: nil, description_en: nil, description_jp: nil, icon: nil}

  defp create_article_category(_) do
    article_category = article_category_fixture()
    %{article_category: article_category}
  end

  describe "Index" do
    setup [:create_article_category]

    test "lists all article_categories", %{conn: conn, article_category: article_category} do
      {:ok, _index_live, html} = live(conn, ~p"/article_categories")

      assert html =~ "Listing Article categories"
      assert html =~ article_category.color
    end

    test "saves new article_category", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/article_categories")

      assert index_live |> element("a", "New Article category") |> render_click() =~
               "New Article category"

      assert_patch(index_live, ~p"/article_categories/new")

      assert index_live
             |> form("#article_category-form", article_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#article_category-form", article_category: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/article_categories")

      html = render(index_live)
      assert html =~ "Article category created successfully"
      assert html =~ "some color"
    end

    test "updates article_category in listing", %{conn: conn, article_category: article_category} do
      {:ok, index_live, _html} = live(conn, ~p"/article_categories")

      assert index_live |> element("#article_categories-#{article_category.id} a", "Edit") |> render_click() =~
               "Edit Article category"

      assert_patch(index_live, ~p"/article_categories/#{article_category}/edit")

      assert index_live
             |> form("#article_category-form", article_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#article_category-form", article_category: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/article_categories")

      html = render(index_live)
      assert html =~ "Article category updated successfully"
      assert html =~ "some updated color"
    end

    test "deletes article_category in listing", %{conn: conn, article_category: article_category} do
      {:ok, index_live, _html} = live(conn, ~p"/article_categories")

      assert index_live |> element("#article_categories-#{article_category.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#article_categories-#{article_category.id}")
    end
  end

  describe "Show" do
    setup [:create_article_category]

    test "displays article_category", %{conn: conn, article_category: article_category} do
      {:ok, _show_live, html} = live(conn, ~p"/article_categories/#{article_category}")

      assert html =~ "Show Article category"
      assert html =~ article_category.color
    end

    test "updates article_category within modal", %{conn: conn, article_category: article_category} do
      {:ok, show_live, _html} = live(conn, ~p"/article_categories/#{article_category}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Article category"

      assert_patch(show_live, ~p"/article_categories/#{article_category}/show/edit")

      assert show_live
             |> form("#article_category-form", article_category: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#article_category-form", article_category: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/article_categories/#{article_category}")

      html = render(show_live)
      assert html =~ "Article category updated successfully"
      assert html =~ "some updated color"
    end
  end
end
