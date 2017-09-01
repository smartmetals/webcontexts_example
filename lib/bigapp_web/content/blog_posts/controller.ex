defmodule BigappWeb.BlogPostController do
  use BigappWeb, :controller

  alias Bigapp.Content
  alias Bigapp.Content.BlogPost

  def index(conn, _params) do
    blog_posts = Content.list_blog_posts()
    render(conn, "index.html", blog_posts: blog_posts)
  end

  def new(conn, _params) do
    changeset = Content.change_blog_post(%BlogPost{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"blog_post" => blog_post_params}) do
    case Content.create_blog_post(blog_post_params) do
      {:ok, blog_post} ->
        conn
        |> put_flash(:info, "Blog post created successfully.")
        |> redirect(to: blog_post_path(conn, :show, blog_post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    blog_post = Content.get_blog_post!(id)
    render(conn, "show.html", blog_post: blog_post)
  end

  def edit(conn, %{"id" => id}) do
    blog_post = Content.get_blog_post!(id)
    changeset = Content.change_blog_post(blog_post)
    render(conn, "edit.html", blog_post: blog_post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "blog_post" => blog_post_params}) do
    blog_post = Content.get_blog_post!(id)

    case Content.update_blog_post(blog_post, blog_post_params) do
      {:ok, blog_post} ->
        conn
        |> put_flash(:info, "Blog post updated successfully.")
        |> redirect(to: blog_post_path(conn, :show, blog_post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", blog_post: blog_post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    blog_post = Content.get_blog_post!(id)
    {:ok, _blog_post} = Content.delete_blog_post(blog_post)

    conn
    |> put_flash(:info, "Blog post deleted successfully.")
    |> redirect(to: blog_post_path(conn, :index))
  end
end
