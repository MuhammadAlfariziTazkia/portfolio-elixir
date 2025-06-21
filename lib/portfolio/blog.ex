defmodule Portfolio.Blog do
  @moduledoc """
  The Blog context.
  """

  import Ecto.Query, warn: false
  alias Portfolio.Repo

  alias Portfolio.Blog.ArticleCategory

  @doc """
  Returns the list of article_categories.

  ## Examples

      iex> list_article_categories()
      [%ArticleCategory{}, ...]

  """
  def list_article_categories do
    Repo.all(ArticleCategory)
  end

  @doc """
  Gets a single article_category.

  Raises `Ecto.NoResultsError` if the Article category does not exist.

  ## Examples

      iex> get_article_category!(123)
      %ArticleCategory{}

      iex> get_article_category!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article_category!(id), do: Repo.get!(ArticleCategory, id)

  @doc """
  Creates a article_category.

  ## Examples

      iex> create_article_category(%{field: value})
      {:ok, %ArticleCategory{}}

      iex> create_article_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article_category(attrs \\ %{}) do
    %ArticleCategory{}
    |> ArticleCategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a article_category.

  ## Examples

      iex> update_article_category(article_category, %{field: new_value})
      {:ok, %ArticleCategory{}}

      iex> update_article_category(article_category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article_category(%ArticleCategory{} = article_category, attrs) do
    article_category
    |> ArticleCategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a article_category.

  ## Examples

      iex> delete_article_category(article_category)
      {:ok, %ArticleCategory{}}

      iex> delete_article_category(article_category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article_category(%ArticleCategory{} = article_category) do
    Repo.delete(article_category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article_category changes.

  ## Examples

      iex> change_article_category(article_category)
      %Ecto.Changeset{data: %ArticleCategory{}}

  """
  def change_article_category(%ArticleCategory{} = article_category, attrs \\ %{}) do
    ArticleCategory.changeset(article_category, attrs)
  end

  alias Portfolio.Blog.Article

  @doc """
  Returns the list of articles.

  ## Examples

      iex> list_articles()
      [%Article{}, ...]

  """
  def list_articles do
    Repo.all(Article)
  end

  @doc """
  Gets a single article.

  Raises `Ecto.NoResultsError` if the Article does not exist.

  ## Examples

      iex> get_article!(123)
      %Article{}

      iex> get_article!(456)
      ** (Ecto.NoResultsError)

  """
  def get_article!(id), do: Repo.get!(Article, id)

  @doc """
  Creates a article.

  ## Examples

      iex> create_article(%{field: value})
      {:ok, %Article{}}

      iex> create_article(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_article(attrs \\ %{}) do
    %Article{}
    |> Article.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a article.

  ## Examples

      iex> update_article(article, %{field: new_value})
      {:ok, %Article{}}

      iex> update_article(article, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_article(%Article{} = article, attrs) do
    article
    |> Article.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a article.

  ## Examples

      iex> delete_article(article)
      {:ok, %Article{}}

      iex> delete_article(article)
      {:error, %Ecto.Changeset{}}

  """
  def delete_article(%Article{} = article) do
    Repo.delete(article)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking article changes.

  ## Examples

      iex> change_article(article)
      %Ecto.Changeset{data: %Article{}}

  """
  def change_article(%Article{} = article, attrs \\ %{}) do
    Article.changeset(article, attrs)
  end
end
