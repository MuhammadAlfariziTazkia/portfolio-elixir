defmodule PortfolioWeb.ArticleCategoryLive.Show do
  use PortfolioWeb, :live_view

  alias Portfolio.Blog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:article_category, Blog.get_article_category!(id))}
  end

  defp page_title(:show), do: "Show Article category"
  defp page_title(:edit), do: "Edit Article category"
end
