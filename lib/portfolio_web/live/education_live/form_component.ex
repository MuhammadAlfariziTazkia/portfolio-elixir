defmodule PortfolioWeb.EducationLive.FormComponent do
  use PortfolioWeb, :live_component

  alias Portfolio.Resume

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage education records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="education-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:institution_name]} type="text" label="Institution name" />
        <.input field={@form[:degree_en]} type="text" label="Degree en" />
        <.input field={@form[:degree_jp]} type="text" label="Degree jp" />
        <.input field={@form[:period]} type="text" label="Period" />
        <.input field={@form[:gpa]} type="text" label="Gpa" />
        <.input field={@form[:description_en]} type="text" label="Description en" />
        <.input field={@form[:description_jp]} type="text" label="Description jp" />
        <.input field={@form[:certificate_url]} type="text" label="Certificate url" />
        <.input field={@form[:transcript_url]} type="text" label="Transcript url" />
        <.input field={@form[:icon]} type="text" label="Icon" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Education</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{education: education} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Resume.change_education(education))
     end)}
  end

  @impl true
  def handle_event("validate", %{"education" => education_params}, socket) do
    changeset = Resume.change_education(socket.assigns.education, education_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"education" => education_params}, socket) do
    save_education(socket, socket.assigns.action, education_params)
  end

  defp save_education(socket, :edit, education_params) do
    case Resume.update_education(socket.assigns.education, education_params) do
      {:ok, education} ->
        notify_parent({:saved, education})

        {:noreply,
         socket
         |> put_flash(:info, "Education updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_education(socket, :new, education_params) do
    case Resume.create_education(education_params) do
      {:ok, education} ->
        notify_parent({:saved, education})

        {:noreply,
         socket
         |> put_flash(:info, "Education created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
