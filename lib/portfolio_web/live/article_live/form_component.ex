defmodule PortfolioWeb.ArticleLive.FormComponent do
  use PortfolioWeb, :live_component

  alias Portfolio.Blog
  require Logger
  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage article records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="article-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title_en]} type="text" label="Title en" />
        <.input field={@form[:title_jp]} type="text" label="Title jp" />
        <.input field={@form[:slug]} type="text" label="Slug" />
        <.input field={@form[:description_en]} type="text" label="Description en" />
        <.input field={@form[:description_jp]} type="text" label="Description jp" />
        <.input field={@form[:content_en]} type="textarea" label="Content en" />
        <.input field={@form[:content_jp]} type="textarea" label="Content jp" />
        <.live_file_input upload={@uploads.thumbnail} />
        <.input field={@form[:published_date]} type="date" label="Published date" />
        <.input field={@form[:read_time]} type="number" label="Read time" />
        <.input
          field={@form[:category_id]}
          type="select"
          label="Category"
          options={Enum.map(@categories, &{&1.name_en, &1.id})}
        />
        <:actions>
          <.button phx-disable-with="Saving...">Save Article</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{article: article} = assigns, socket) do
    categories = Portfolio.Blog.list_article_categories()

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:categories, categories)
     |> assign_new(:form, fn -> to_form(Blog.change_article(article)) end)
     |> allow_upload(:thumbnail,
       accept: ~w(.jpg .jpeg .png),
       max_entries: 1,
       max_file_size: 5_000_000
     )}
  end

  @impl true
  def handle_event("validate", %{"article" => article_params}, socket) do
    changeset = Blog.change_article(socket.assigns.article, article_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"article" => article_params}, socket) do
  Logger.debug("Mulai proses upload...")

  uploaded_urls =
    consume_uploaded_entries(socket, :thumbnail, fn %{path: path}, entry ->
      Logger.debug("Nama file: #{entry.client_name}")
      dest = Path.join("priv/static/uploads", entry.client_name)
      File.mkdir_p!("priv/static/uploads")
      File.cp!(path, dest)
      {:ok, "/uploads/#{entry.client_name}"}
    end)

  Logger.debug("Uploaded URLs: #{inspect(uploaded_urls)}")

  case uploaded_urls do
    [url] ->
      Logger.debug("MASUK ")
      article_params = Map.put(article_params, "thumbnail", url)
      save_article(socket, socket.assigns.action, article_params)

    _ ->
      Logger.debug("GAMASUK")
      save_article(socket, socket.assigns.action, article_params)
  end
end

  defp save_article(socket, :edit, article_params) do
    case Blog.update_article(socket.assigns.article, article_params) do
      {:ok, article} ->
        notify_parent({:saved, article})

        {:noreply,
         socket
         |> put_flash(:info, "Article updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_article(socket, :new, article_params) do
    case Blog.create_article(article_params) do
      {:ok, article} ->
        notify_parent({:saved, article})

        {:noreply,
         socket
         |> put_flash(:info, "Article created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
