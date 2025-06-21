defmodule PortfolioWeb.WorkExperienceLive.Show do
  use PortfolioWeb, :live_view

  alias Portfolio.Resume

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:work_experience, Resume.get_work_experience!(id))}
  end

  defp page_title(:show), do: "Show Work experience"
  defp page_title(:edit), do: "Edit Work experience"
end
