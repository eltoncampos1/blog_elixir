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

  def show(conn, %{"id" => id}) do
    post = Blog.Repo.get!(Post, id)
    render(conn, "show.html", post: post)
  end

  def create(conn, %{"id" => id}) do
    post = Blog.Repo.get!(Post, id)
    render(conn, "show.html", post: post)
  end
end
