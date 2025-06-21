defmodule PortfolioWeb.EducationLive.Index do
  use PortfolioWeb, :live_view

  alias Portfolio.Resume
  alias Portfolio.Resume.Education

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :education_collection, Resume.list_education())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Education")
    |> assign(:education, Resume.get_education!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Education")
    |> assign(:education, %Education{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Education")
    |> assign(:education, nil)
  end

  @impl true
  def handle_info({PortfolioWeb.EducationLive.FormComponent, {:saved, education}}, socket) do
    {:noreply, stream_insert(socket, :education_collection, education)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    education = Resume.get_education!(id)
    {:ok, _} = Resume.delete_education(education)

    {:noreply, stream_delete(socket, :education_collection, education)}
  end
end
