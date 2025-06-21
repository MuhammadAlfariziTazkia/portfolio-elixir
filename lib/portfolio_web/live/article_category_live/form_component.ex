defmodule PortfolioWeb.ArticleCategoryLive.FormComponent do
  use PortfolioWeb, :live_component

  alias Portfolio.Blog

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage article_category records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="article_category-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name_en]} type="text" label="Name en" />
        <.input field={@form[:name_jp]} type="text" label="Name jp" />
        <.input field={@form[:slug]} type="text" label="Slug" />
        <.input field={@form[:description_en]} type="text" label="Description en" />
        <.input field={@form[:description_jp]} type="text" label="Description jp" />
        <.input field={@form[:icon]} type="text" label="Icon" />
        <.input field={@form[:color]} type="text" label="Color" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Article category</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{article_category: article_category} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Blog.change_article_category(article_category))
     end)}
  end

  @impl true
  def handle_event("validate", %{"article_category" => article_category_params}, socket) do
    changeset = Blog.change_article_category(socket.assigns.article_category, article_category_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"article_category" => article_category_params}, socket) do
    save_article_category(socket, socket.assigns.action, article_category_params)
  end

  defp save_article_category(socket, :edit, article_category_params) do
    case Blog.update_article_category(socket.assigns.article_category, article_category_params) do
      {:ok, article_category} ->
        notify_parent({:saved, article_category})

        {:noreply,
         socket
         |> put_flash(:info, "Article category updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_article_category(socket, :new, article_category_params) do
    case Blog.create_article_category(article_category_params) do
      {:ok, article_category} ->
        notify_parent({:saved, article_category})

        {:noreply,
         socket
         |> put_flash(:info, "Article category created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
