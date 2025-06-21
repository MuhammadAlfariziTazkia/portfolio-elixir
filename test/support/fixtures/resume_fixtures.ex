defmodule Portfolio.ResumeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Portfolio.Resume` context.
  """

  @doc """
  Generate a skill.
  """
  def skill_fixture(attrs \\ %{}) do
    {:ok, skill} =
      attrs
      |> Enum.into(%{
        color: "some color",
        icon: "some icon",
        name: "some name"
      })
      |> Portfolio.Resume.create_skill()

    skill
  end

  @doc """
  Generate a work_experience.
  """
  def work_experience_fixture(attrs \\ %{}) do
    {:ok, work_experience} =
      attrs
      |> Enum.into(%{
        company: "some company",
        description_en: "some description_en",
        description_jp: "some description_jp",
        detailed_achievements_en: "some detailed_achievements_en",
        detailed_achievements_jp: "some detailed_achievements_jp",
        full_description_en: "some full_description_en",
        full_description_jp: "some full_description_jp",
        key_achievements_en: "some key_achievements_en",
        key_achievements_jp: "some key_achievements_jp",
        logo: "some logo",
        period: "some period",
        position_en: "some position_en",
        position_jp: "some position_jp",
        type_en: "some type_en",
        type_jp: "some type_jp"
      })
      |> Portfolio.Resume.create_work_experience()

    work_experience
  end

  @doc """
  Generate a education.
  """
  def education_fixture(attrs \\ %{}) do
    {:ok, education} =
      attrs
      |> Enum.into(%{
        certificate_url: "some certificate_url",
        degree_en: "some degree_en",
        degree_jp: "some degree_jp",
        description_en: "some description_en",
        description_jp: "some description_jp",
        gpa: "some gpa",
        icon: "some icon",
        institution_name: "some institution_name",
        period: "some period",
        transcript_url: "some transcript_url"
      })
      |> Portfolio.Resume.create_education()

    education
  end

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        description_en: "some description_en",
        description_jp: "some description_jp",
        is_public: true,
        project_url: "some project_url",
        role_en: "some role_en",
        role_jp: "some role_jp",
        title: "some title"
      })
      |> Portfolio.Resume.create_project()

    project
  end
end
