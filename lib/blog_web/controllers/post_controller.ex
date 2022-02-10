defmodule BlogWeb.PostController do
  use BlogWeb, :controller

  alias Blog.Posts
  alias Posts.Post

  plug BlogWeb.Plug.RequireAuth when action in [:create, :new, :edit, :update, :delete]
  plug :check_owner when action in [:edit, :update, :delete]


  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    post = Posts.get_post(id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post(id)
    render(conn, "show.html", post: post)
  end

  def create(conn, %{"post" => post}) do
    case Posts.create_post(conn.assigns[:user], post) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post successfully created!")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    Posts.delete_post(id)

    conn
    |> put_flash(:info, "Post Successfully deleted.")
    |> redirect(to: Routes.post_path(conn, :index))
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post(id)

    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post successfully updated!")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, post: post)
    end
  end

  def check_owner(conn, _params) do
    %{params: %{"id" => post_id}} = conn

    if Posts.get_post(post_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You don't have authorization to do this operation.")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
