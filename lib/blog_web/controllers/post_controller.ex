defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.Posts.Post

  def index(conn, _params) do
    posts = Blog.Repo.all(Post)
    render(conn, "index.html", posts: posts)
  end

  def new(conn, params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post = Blog.Repo.get(Blog.Posts.Post, id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    post = Blog.Repo.get!(Post, id)
    render(conn, "show.html", post: post)
  end

  def create(conn, %{"post" => post}) do
    post = Post.changeset(%Post{}, post)
    |> Blog.Repo.insert()

    case post do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post successfully created!")
        |> redirect(to: Routes.post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Blog.Repo.get!(Blog.Posts.Post, id)
    Blog.Repo.delete!(post)

    conn
      |> put_flash(:info, "Post Successfully deleted.")
      |> redirect(to: Routes.post_path(conn, :index))
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Blog.Repo.get!(Blog.Posts.Post, id)
    changeset = Blog.Posts.Post.changeset(post, post_params)
    post = Blog.Repo.update(changeset)

    case post do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post successfully updated!")
        |> redirect(to: Routes.post_path(conn, :show, post))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
