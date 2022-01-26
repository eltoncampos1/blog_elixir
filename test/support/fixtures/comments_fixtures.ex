defmodule Blog.CommentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blog.Comments` context.
  """

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    post = Blog.PostsTest.post_fixture()

    att = attrs
    |> Enum.into(%{
      content: "some content"
    })

    {:ok, comment} =
      post.id
      |> Blog.Comments.create_comment(att)

    comment
  end
end
