defmodule PortfolioWeb.WorkExperienceLive.FormComponent do
  use PortfolioWeb, :live_component

  alias Portfolio.Resume

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage work_experience records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="work_experience-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:company]} type="text" label="Company" />
        <.input field={@form[:position_en]} type="text" label="Position en" />
        <.input field={@form[:position_jp]} type="text" label="Position jp" />
        <.input field={@form[:period]} type="text" label="Period" />
        <.input field={@form[:type_en]} type="text" label="Type en" />
        <.input field={@form[:type_jp]} type="text" label="Type jp" />
        <.input field={@form[:logo]} type="text" label="Logo" />
        <.input field={@form[:description_en]} type="text" label="Description en" />
        <.input field={@form[:description_jp]} type="text" label="Description jp" />
        <.input field={@form[:key_achievements_en]} type="text" label="Key achievements en" />
        <.input field={@form[:key_achievements_jp]} type="text" label="Key achievements jp" />
        <.input field={@form[:full_description_en]} type="text" label="Full description en" />
        <.input field={@form[:full_description_jp]} type="text" label="Full description jp" />
        <.input field={@form[:detailed_achievements_en]} type="text" label="Detailed achievements en" />
        <.input field={@form[:detailed_achievements_jp]} type="text" label="Detailed achievements jp" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Work experience</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{work_experience: work_experience} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Resume.change_work_experience(work_experience))
     end)}
  end

  @impl true
  def handle_event("validate", %{"work_experience" => work_experience_params}, socket) do
    changeset = Resume.change_work_experience(socket.assigns.work_experience, work_experience_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"work_experience" => work_experience_params}, socket) do
    save_work_experience(socket, socket.assigns.action, work_experience_params)
  end

  defp save_work_experience(socket, :edit, work_experience_params) do
    case Resume.update_work_experience(socket.assigns.work_experience, work_experience_params) do
      {:ok, work_experience} ->
        notify_parent({:saved, work_experience})

        {:noreply,
         socket
         |> put_flash(:info, "Work experience updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_work_experience(socket, :new, work_experience_params) do
    case Resume.create_work_experience(work_experience_params) do
      {:ok, work_experience} ->
        notify_parent({:saved, work_experience})

        {:noreply,
         socket
         |> put_flash(:info, "Work experience created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
