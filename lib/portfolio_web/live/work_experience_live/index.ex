defmodule PortfolioWeb.WorkExperienceLive.Index do
  use PortfolioWeb, :live_view

  alias Portfolio.Resume
  alias Portfolio.Resume.WorkExperience

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :work_experiences, Resume.list_work_experiences())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Work experience")
    |> assign(:work_experience, Resume.get_work_experience!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Work experience")
    |> assign(:work_experience, %WorkExperience{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Work experiences")
    |> assign(:work_experience, nil)
  end

  @impl true
  def handle_info({PortfolioWeb.WorkExperienceLive.FormComponent, {:saved, work_experience}}, socket) do
    {:noreply, stream_insert(socket, :work_experiences, work_experience)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    work_experience = Resume.get_work_experience!(id)
    {:ok, _} = Resume.delete_work_experience(work_experience)

    {:noreply, stream_delete(socket, :work_experiences, work_experience)}
  end
end
