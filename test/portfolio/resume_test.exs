defmodule Portfolio.ResumeTest do
  use Portfolio.DataCase

  alias Portfolio.Resume

  describe "skills" do
    alias Portfolio.Resume.Skill

    import Portfolio.ResumeFixtures

    @invalid_attrs %{name: nil, color: nil, icon: nil}

    test "list_skills/0 returns all skills" do
      skill = skill_fixture()
      assert Resume.list_skills() == [skill]
    end

    test "get_skill!/1 returns the skill with given id" do
      skill = skill_fixture()
      assert Resume.get_skill!(skill.id) == skill
    end

    test "create_skill/1 with valid data creates a skill" do
      valid_attrs = %{name: "some name", color: "some color", icon: "some icon"}

      assert {:ok, %Skill{} = skill} = Resume.create_skill(valid_attrs)
      assert skill.name == "some name"
      assert skill.color == "some color"
      assert skill.icon == "some icon"
    end

    test "create_skill/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resume.create_skill(@invalid_attrs)
    end

    test "update_skill/2 with valid data updates the skill" do
      skill = skill_fixture()
      update_attrs = %{name: "some updated name", color: "some updated color", icon: "some updated icon"}

      assert {:ok, %Skill{} = skill} = Resume.update_skill(skill, update_attrs)
      assert skill.name == "some updated name"
      assert skill.color == "some updated color"
      assert skill.icon == "some updated icon"
    end

    test "update_skill/2 with invalid data returns error changeset" do
      skill = skill_fixture()
      assert {:error, %Ecto.Changeset{}} = Resume.update_skill(skill, @invalid_attrs)
      assert skill == Resume.get_skill!(skill.id)
    end

    test "delete_skill/1 deletes the skill" do
      skill = skill_fixture()
      assert {:ok, %Skill{}} = Resume.delete_skill(skill)
      assert_raise Ecto.NoResultsError, fn -> Resume.get_skill!(skill.id) end
    end

    test "change_skill/1 returns a skill changeset" do
      skill = skill_fixture()
      assert %Ecto.Changeset{} = Resume.change_skill(skill)
    end
  end

  describe "work_experiences" do
    alias Portfolio.Resume.WorkExperience

    import Portfolio.ResumeFixtures

    @invalid_attrs %{period: nil, company: nil, position_en: nil, position_jp: nil, type_en: nil, type_jp: nil, logo: nil, description_en: nil, description_jp: nil, key_achievements_en: nil, key_achievements_jp: nil, full_description_en: nil, full_description_jp: nil, detailed_achievements_en: nil, detailed_achievements_jp: nil}

    test "list_work_experiences/0 returns all work_experiences" do
      work_experience = work_experience_fixture()
      assert Resume.list_work_experiences() == [work_experience]
    end

    test "get_work_experience!/1 returns the work_experience with given id" do
      work_experience = work_experience_fixture()
      assert Resume.get_work_experience!(work_experience.id) == work_experience
    end

    test "create_work_experience/1 with valid data creates a work_experience" do
      valid_attrs = %{period: "some period", company: "some company", position_en: "some position_en", position_jp: "some position_jp", type_en: "some type_en", type_jp: "some type_jp", logo: "some logo", description_en: "some description_en", description_jp: "some description_jp", key_achievements_en: "some key_achievements_en", key_achievements_jp: "some key_achievements_jp", full_description_en: "some full_description_en", full_description_jp: "some full_description_jp", detailed_achievements_en: "some detailed_achievements_en", detailed_achievements_jp: "some detailed_achievements_jp"}

      assert {:ok, %WorkExperience{} = work_experience} = Resume.create_work_experience(valid_attrs)
      assert work_experience.period == "some period"
      assert work_experience.company == "some company"
      assert work_experience.position_en == "some position_en"
      assert work_experience.position_jp == "some position_jp"
      assert work_experience.type_en == "some type_en"
      assert work_experience.type_jp == "some type_jp"
      assert work_experience.logo == "some logo"
      assert work_experience.description_en == "some description_en"
      assert work_experience.description_jp == "some description_jp"
      assert work_experience.key_achievements_en == "some key_achievements_en"
      assert work_experience.key_achievements_jp == "some key_achievements_jp"
      assert work_experience.full_description_en == "some full_description_en"
      assert work_experience.full_description_jp == "some full_description_jp"
      assert work_experience.detailed_achievements_en == "some detailed_achievements_en"
      assert work_experience.detailed_achievements_jp == "some detailed_achievements_jp"
    end

    test "create_work_experience/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resume.create_work_experience(@invalid_attrs)
    end

    test "update_work_experience/2 with valid data updates the work_experience" do
      work_experience = work_experience_fixture()
      update_attrs = %{period: "some updated period", company: "some updated company", position_en: "some updated position_en", position_jp: "some updated position_jp", type_en: "some updated type_en", type_jp: "some updated type_jp", logo: "some updated logo", description_en: "some updated description_en", description_jp: "some updated description_jp", key_achievements_en: "some updated key_achievements_en", key_achievements_jp: "some updated key_achievements_jp", full_description_en: "some updated full_description_en", full_description_jp: "some updated full_description_jp", detailed_achievements_en: "some updated detailed_achievements_en", detailed_achievements_jp: "some updated detailed_achievements_jp"}

      assert {:ok, %WorkExperience{} = work_experience} = Resume.update_work_experience(work_experience, update_attrs)
      assert work_experience.period == "some updated period"
      assert work_experience.company == "some updated company"
      assert work_experience.position_en == "some updated position_en"
      assert work_experience.position_jp == "some updated position_jp"
      assert work_experience.type_en == "some updated type_en"
      assert work_experience.type_jp == "some updated type_jp"
      assert work_experience.logo == "some updated logo"
      assert work_experience.description_en == "some updated description_en"
      assert work_experience.description_jp == "some updated description_jp"
      assert work_experience.key_achievements_en == "some updated key_achievements_en"
      assert work_experience.key_achievements_jp == "some updated key_achievements_jp"
      assert work_experience.full_description_en == "some updated full_description_en"
      assert work_experience.full_description_jp == "some updated full_description_jp"
      assert work_experience.detailed_achievements_en == "some updated detailed_achievements_en"
      assert work_experience.detailed_achievements_jp == "some updated detailed_achievements_jp"
    end

    test "update_work_experience/2 with invalid data returns error changeset" do
      work_experience = work_experience_fixture()
      assert {:error, %Ecto.Changeset{}} = Resume.update_work_experience(work_experience, @invalid_attrs)
      assert work_experience == Resume.get_work_experience!(work_experience.id)
    end

    test "delete_work_experience/1 deletes the work_experience" do
      work_experience = work_experience_fixture()
      assert {:ok, %WorkExperience{}} = Resume.delete_work_experience(work_experience)
      assert_raise Ecto.NoResultsError, fn -> Resume.get_work_experience!(work_experience.id) end
    end

    test "change_work_experience/1 returns a work_experience changeset" do
      work_experience = work_experience_fixture()
      assert %Ecto.Changeset{} = Resume.change_work_experience(work_experience)
    end
  end

  describe "education" do
    alias Portfolio.Resume.Education

    import Portfolio.ResumeFixtures

    @invalid_attrs %{period: nil, institution_name: nil, degree_en: nil, degree_jp: nil, gpa: nil, description_en: nil, description_jp: nil, certificate_url: nil, transcript_url: nil, icon: nil}

    test "list_education/0 returns all education" do
      education = education_fixture()
      assert Resume.list_education() == [education]
    end

    test "get_education!/1 returns the education with given id" do
      education = education_fixture()
      assert Resume.get_education!(education.id) == education
    end

    test "create_education/1 with valid data creates a education" do
      valid_attrs = %{period: "some period", institution_name: "some institution_name", degree_en: "some degree_en", degree_jp: "some degree_jp", gpa: "some gpa", description_en: "some description_en", description_jp: "some description_jp", certificate_url: "some certificate_url", transcript_url: "some transcript_url", icon: "some icon"}

      assert {:ok, %Education{} = education} = Resume.create_education(valid_attrs)
      assert education.period == "some period"
      assert education.institution_name == "some institution_name"
      assert education.degree_en == "some degree_en"
      assert education.degree_jp == "some degree_jp"
      assert education.gpa == "some gpa"
      assert education.description_en == "some description_en"
      assert education.description_jp == "some description_jp"
      assert education.certificate_url == "some certificate_url"
      assert education.transcript_url == "some transcript_url"
      assert education.icon == "some icon"
    end

    test "create_education/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resume.create_education(@invalid_attrs)
    end

    test "update_education/2 with valid data updates the education" do
      education = education_fixture()
      update_attrs = %{period: "some updated period", institution_name: "some updated institution_name", degree_en: "some updated degree_en", degree_jp: "some updated degree_jp", gpa: "some updated gpa", description_en: "some updated description_en", description_jp: "some updated description_jp", certificate_url: "some updated certificate_url", transcript_url: "some updated transcript_url", icon: "some updated icon"}

      assert {:ok, %Education{} = education} = Resume.update_education(education, update_attrs)
      assert education.period == "some updated period"
      assert education.institution_name == "some updated institution_name"
      assert education.degree_en == "some updated degree_en"
      assert education.degree_jp == "some updated degree_jp"
      assert education.gpa == "some updated gpa"
      assert education.description_en == "some updated description_en"
      assert education.description_jp == "some updated description_jp"
      assert education.certificate_url == "some updated certificate_url"
      assert education.transcript_url == "some updated transcript_url"
      assert education.icon == "some updated icon"
    end

    test "update_education/2 with invalid data returns error changeset" do
      education = education_fixture()
      assert {:error, %Ecto.Changeset{}} = Resume.update_education(education, @invalid_attrs)
      assert education == Resume.get_education!(education.id)
    end

    test "delete_education/1 deletes the education" do
      education = education_fixture()
      assert {:ok, %Education{}} = Resume.delete_education(education)
      assert_raise Ecto.NoResultsError, fn -> Resume.get_education!(education.id) end
    end

    test "change_education/1 returns a education changeset" do
      education = education_fixture()
      assert %Ecto.Changeset{} = Resume.change_education(education)
    end
  end

  describe "projects" do
    alias Portfolio.Resume.Project

    import Portfolio.ResumeFixtures

    @invalid_attrs %{title: nil, role_en: nil, role_jp: nil, description_en: nil, description_jp: nil, project_url: nil, is_public: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Resume.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Resume.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{title: "some title", role_en: "some role_en", role_jp: "some role_jp", description_en: "some description_en", description_jp: "some description_jp", project_url: "some project_url", is_public: true}

      assert {:ok, %Project{} = project} = Resume.create_project(valid_attrs)
      assert project.title == "some title"
      assert project.role_en == "some role_en"
      assert project.role_jp == "some role_jp"
      assert project.description_en == "some description_en"
      assert project.description_jp == "some description_jp"
      assert project.project_url == "some project_url"
      assert project.is_public == true
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resume.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      update_attrs = %{title: "some updated title", role_en: "some updated role_en", role_jp: "some updated role_jp", description_en: "some updated description_en", description_jp: "some updated description_jp", project_url: "some updated project_url", is_public: false}

      assert {:ok, %Project{} = project} = Resume.update_project(project, update_attrs)
      assert project.title == "some updated title"
      assert project.role_en == "some updated role_en"
      assert project.role_jp == "some updated role_jp"
      assert project.description_en == "some updated description_en"
      assert project.description_jp == "some updated description_jp"
      assert project.project_url == "some updated project_url"
      assert project.is_public == false
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Resume.update_project(project, @invalid_attrs)
      assert project == Resume.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Resume.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Resume.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Resume.change_project(project)
    end
  end
end
