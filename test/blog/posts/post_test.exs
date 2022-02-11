defmodule Blog.PostsTest do
  @moduledoc """
  Post context tests
  """

  use Blog.DataCase
  alias Blog.{Posts, Posts.Post}

  @valid_post %{
    title: "teste",
    description: "desc_test"
  }

  @updated_post %{
    title: "teste_update",
    description: "desc_test_updated"
  }

  def post_fixture(_attrs \\ %{}) do
    user = Blog.Accounts.get_user!(1)
    {:ok, post} = Posts.create_post(user, @valid_post)
    post
  end

  test "create_post/1 with valid data" do
    user = Blog.Accounts.get_user!(1)

    assert {:ok, %Post{} = post} = Posts.create_post(user, @valid_post)
    assert post.title == "teste"
    assert post.description == "desc_test"
  end

  test "list_posts/0 return all posts" do
    post_fixture()
    assert Posts.list_posts() |> Enum.count() == 2
  end

  test "get_post/1 return all posts" do
    post = post_fixture()
    assert Posts.get_post(post.id) == post
  end

  test "update_post/2 with valid data" do
    post = post_fixture()

    assert {:ok, %Post{} = post} = Posts.update_post(post, @updated_post)
    assert post.title == "teste_update"
    assert post.description == "desc_test_updated"
  end

  test "delete_post/1" do
    post = post_fixture()
    assert post = Posts.delete_post(post.id)
    assert_raise Ecto.NoResultsError, fn -> Posts.get_post(post.id) end
  end
end
