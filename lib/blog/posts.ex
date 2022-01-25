defmodule Blog.Posts do
  @moduledoc """
  Posts context
  """

  alias Blog.{Posts.Post, Repo}

  def list_posts, do: Repo.all(Post)

  def get_post(id), do: Repo.get!(Post, id)

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(id, post_params) do
    get_post(id)
    |> Post.changeset(post_params)
    |> Repo.update()
  end

  def delete_post(id) do
    get_post(id)
    |> Repo.delete!()
  end
end
