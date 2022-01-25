defmodule Blog.PostsTest do
  use Blog.DataCase
  alias Blog.{Posts, Posts.Post}

  @valid_post %{
    title: "teste",
    description: "desc_test"
  }

  test "create_post/1 with valid data" do
    assert {:ok, %Post{} = post} = Posts.create_post(@valid_post)
    assert post.title == "teste"
    assert post.description == "desc_test"
  end
end
