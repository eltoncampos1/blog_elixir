defmodule Blog.Posts do
  @moduledoc """
  Posts context
  """

  alias Blog.{Posts.Post, Repo}

  def list_posts, do: Repo.all(Post)

  def get_post(id), do: Repo.get!(Post, id)

  def get_post_with_comments(id), do: Repo.get!(Post, id) |> Repo.preload(:comments)

  def create_post(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:posts)
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(post, post_params) do
    post
    |> Post.changeset(post_params)
    |> Repo.update()
  end

  def delete_post(id) do
    get_post(id)
    |> Repo.delete!()
  end
end
