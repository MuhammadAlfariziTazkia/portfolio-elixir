defmodule PortfolioWeb.Router do
  use PortfolioWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {PortfolioWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PortfolioWeb do
    pipe_through :browser

    get "/", PageController, :home

     live "/skills", SkillLive.Index, :index
    live "/skills/new", SkillLive.Index, :new
    live "/skills/:id/edit", SkillLive.Index, :edit

    live "/skills/:id", SkillLive.Show, :show
    live "/skills/:id/show/edit", SkillLive.Show, :edit

    live "/work_experiences", WorkExperienceLive.Index, :index
    live "/work_experiences/new", WorkExperienceLive.Index, :new
    live "/work_experiences/:id/edit", WorkExperienceLive.Index, :edit

    live "/work_experiences/:id", WorkExperienceLive.Show, :show
    live "/work_experiences/:id/show/edit", WorkExperienceLive.Show, :edit

    live "/education", EducationLive.Index, :index
    live "/education/new", EducationLive.Index, :new
    live "/education/:id/edit", EducationLive.Index, :edit

    live "/education/:id", EducationLive.Show, :show
    live "/education/:id/show/edit", EducationLive.Show, :edit

    live "/projects", ProjectLive.Index, :index
    live "/projects/new", ProjectLive.Index, :new
    live "/projects/:id/edit", ProjectLive.Index, :edit

    live "/projects/:id", ProjectLive.Show, :show
    live "/projects/:id/show/edit", ProjectLive.Show, :edit

    live "/article_categories", ArticleCategoryLive.Index, :index
    live "/article_categories/new", ArticleCategoryLive.Index, :new
    live "/article_categories/:id/edit", ArticleCategoryLive.Index, :edit

    live "/article_categories/:id", ArticleCategoryLive.Show, :show
    live "/article_categories/:id/show/edit", ArticleCategoryLive.Show, :edit

    live "/articles", ArticleLive.Index, :index
    live "/articles/new", ArticleLive.Index, :new
    live "/articles/:id/edit", ArticleLive.Index, :edit

    live "/articles/:id", ArticleLive.Show, :show
    live "/articles/:id/show/edit", ArticleLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", PortfolioWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:portfolio, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: PortfolioWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
