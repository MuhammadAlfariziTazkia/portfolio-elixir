defmodule PortfolioWeb.WorkExperienceLiveTest do
  use PortfolioWeb.ConnCase

  import Phoenix.LiveViewTest
  import Portfolio.ResumeFixtures

  @create_attrs %{period: "some period", company: "some company", position_en: "some position_en", position_jp: "some position_jp", type_en: "some type_en", type_jp: "some type_jp", logo: "some logo", description_en: "some description_en", description_jp: "some description_jp", key_achievements_en: "some key_achievements_en", key_achievements_jp: "some key_achievements_jp", full_description_en: "some full_description_en", full_description_jp: "some full_description_jp", detailed_achievements_en: "some detailed_achievements_en", detailed_achievements_jp: "some detailed_achievements_jp"}
  @update_attrs %{period: "some updated period", company: "some updated company", position_en: "some updated position_en", position_jp: "some updated position_jp", type_en: "some updated type_en", type_jp: "some updated type_jp", logo: "some updated logo", description_en: "some updated description_en", description_jp: "some updated description_jp", key_achievements_en: "some updated key_achievements_en", key_achievements_jp: "some updated key_achievements_jp", full_description_en: "some updated full_description_en", full_description_jp: "some updated full_description_jp", detailed_achievements_en: "some updated detailed_achievements_en", detailed_achievements_jp: "some updated detailed_achievements_jp"}
  @invalid_attrs %{period: nil, company: nil, position_en: nil, position_jp: nil, type_en: nil, type_jp: nil, logo: nil, description_en: nil, description_jp: nil, key_achievements_en: nil, key_achievements_jp: nil, full_description_en: nil, full_description_jp: nil, detailed_achievements_en: nil, detailed_achievements_jp: nil}

  defp create_work_experience(_) do
    work_experience = work_experience_fixture()
    %{work_experience: work_experience}
  end

  describe "Index" do
    setup [:create_work_experience]

    test "lists all work_experiences", %{conn: conn, work_experience: work_experience} do
      {:ok, _index_live, html} = live(conn, ~p"/work_experiences")

      assert html =~ "Listing Work experiences"
      assert html =~ work_experience.period
    end

    test "saves new work_experience", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/work_experiences")

      assert index_live |> element("a", "New Work experience") |> render_click() =~
               "New Work experience"

      assert_patch(index_live, ~p"/work_experiences/new")

      assert index_live
             |> form("#work_experience-form", work_experience: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#work_experience-form", work_experience: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/work_experiences")

      html = render(index_live)
      assert html =~ "Work experience created successfully"
      assert html =~ "some period"
    end

    test "updates work_experience in listing", %{conn: conn, work_experience: work_experience} do
      {:ok, index_live, _html} = live(conn, ~p"/work_experiences")

      assert index_live |> element("#work_experiences-#{work_experience.id} a", "Edit") |> render_click() =~
               "Edit Work experience"

      assert_patch(index_live, ~p"/work_experiences/#{work_experience}/edit")

      assert index_live
             |> form("#work_experience-form", work_experience: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#work_experience-form", work_experience: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/work_experiences")

      html = render(index_live)
      assert html =~ "Work experience updated successfully"
      assert html =~ "some updated period"
    end

    test "deletes work_experience in listing", %{conn: conn, work_experience: work_experience} do
      {:ok, index_live, _html} = live(conn, ~p"/work_experiences")

      assert index_live |> element("#work_experiences-#{work_experience.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#work_experiences-#{work_experience.id}")
    end
  end

  describe "Show" do
    setup [:create_work_experience]

    test "displays work_experience", %{conn: conn, work_experience: work_experience} do
      {:ok, _show_live, html} = live(conn, ~p"/work_experiences/#{work_experience}")

      assert html =~ "Show Work experience"
      assert html =~ work_experience.period
    end

    test "updates work_experience within modal", %{conn: conn, work_experience: work_experience} do
      {:ok, show_live, _html} = live(conn, ~p"/work_experiences/#{work_experience}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Work experience"

      assert_patch(show_live, ~p"/work_experiences/#{work_experience}/show/edit")

      assert show_live
             |> form("#work_experience-form", work_experience: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#work_experience-form", work_experience: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/work_experiences/#{work_experience}")

      html = render(show_live)
      assert html =~ "Work experience updated successfully"
      assert html =~ "some updated period"
    end
  end
end
