defmodule PortfolioWeb.EducationLiveTest do
  use PortfolioWeb.ConnCase

  import Phoenix.LiveViewTest
  import Portfolio.ResumeFixtures

  @create_attrs %{period: "some period", institution_name: "some institution_name", degree_en: "some degree_en", degree_jp: "some degree_jp", gpa: "some gpa", description_en: "some description_en", description_jp: "some description_jp", certificate_url: "some certificate_url", transcript_url: "some transcript_url", icon: "some icon"}
  @update_attrs %{period: "some updated period", institution_name: "some updated institution_name", degree_en: "some updated degree_en", degree_jp: "some updated degree_jp", gpa: "some updated gpa", description_en: "some updated description_en", description_jp: "some updated description_jp", certificate_url: "some updated certificate_url", transcript_url: "some updated transcript_url", icon: "some updated icon"}
  @invalid_attrs %{period: nil, institution_name: nil, degree_en: nil, degree_jp: nil, gpa: nil, description_en: nil, description_jp: nil, certificate_url: nil, transcript_url: nil, icon: nil}

  defp create_education(_) do
    education = education_fixture()
    %{education: education}
  end

  describe "Index" do
    setup [:create_education]

    test "lists all education", %{conn: conn, education: education} do
      {:ok, _index_live, html} = live(conn, ~p"/education")

      assert html =~ "Listing Education"
      assert html =~ education.period
    end

    test "saves new education", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/education")

      assert index_live |> element("a", "New Education") |> render_click() =~
               "New Education"

      assert_patch(index_live, ~p"/education/new")

      assert index_live
             |> form("#education-form", education: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#education-form", education: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/education")

      html = render(index_live)
      assert html =~ "Education created successfully"
      assert html =~ "some period"
    end

    test "updates education in listing", %{conn: conn, education: education} do
      {:ok, index_live, _html} = live(conn, ~p"/education")

      assert index_live |> element("#education-#{education.id} a", "Edit") |> render_click() =~
               "Edit Education"

      assert_patch(index_live, ~p"/education/#{education}/edit")

      assert index_live
             |> form("#education-form", education: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#education-form", education: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/education")

      html = render(index_live)
      assert html =~ "Education updated successfully"
      assert html =~ "some updated period"
    end

    test "deletes education in listing", %{conn: conn, education: education} do
      {:ok, index_live, _html} = live(conn, ~p"/education")

      assert index_live |> element("#education-#{education.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#education-#{education.id}")
    end
  end

  describe "Show" do
    setup [:create_education]

    test "displays education", %{conn: conn, education: education} do
      {:ok, _show_live, html} = live(conn, ~p"/education/#{education}")

      assert html =~ "Show Education"
      assert html =~ education.period
    end

    test "updates education within modal", %{conn: conn, education: education} do
      {:ok, show_live, _html} = live(conn, ~p"/education/#{education}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Education"

      assert_patch(show_live, ~p"/education/#{education}/show/edit")

      assert show_live
             |> form("#education-form", education: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#education-form", education: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/education/#{education}")

      html = render(show_live)
      assert html =~ "Education updated successfully"
      assert html =~ "some updated period"
    end
  end
end
