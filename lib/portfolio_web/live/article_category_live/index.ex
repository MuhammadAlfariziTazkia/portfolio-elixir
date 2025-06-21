defmodule PortfolioWeb.ArticleCategoryLive.Index do
  use PortfolioWeb, :live_view

  alias Portfolio.Blog
  alias Portfolio.Blog.ArticleCategory

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :article_categories, Blog.list_article_categories())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Article category")
    |> assign(:article_category, Blog.get_article_category!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Article category")
    |> assign(:article_category, %ArticleCategory{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Article categories")
    |> assign(:article_category, nil)
  end

  @impl true
  def handle_info({PortfolioWeb.ArticleCategoryLive.FormComponent, {:saved, article_category}}, socket) do
    {:noreply, stream_insert(socket, :article_categories, article_category)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    article_category = Blog.get_article_category!(id)
    {:ok, _} = Blog.delete_article_category(article_category)

    {:noreply, stream_delete(socket, :article_categories, article_category)}
  end
end
