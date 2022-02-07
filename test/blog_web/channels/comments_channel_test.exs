defmodule BlogWeb.CommentsChannelTest do
  @moduledoc """
  Comments websocket channel test
  """

  use BlogWeb.ChannelCase
  alias Blog.Posts
  alias BlogWeb.UserSocket

  @valid_post %{
    title: "teste_title",
    description: "test_desc"
  }

  setup do
    {:ok, post} = Posts.create_post(@valid_post)
    {:ok, socket} = connect(UserSocket, %{})

    {:ok, socket: socket, post: post}
  end

  test "should connect to socket", %{socket: socket, post: post} do
    {:ok, comments, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})

    assert post.id == socket.assigns.post_id
    assert [] == comments.comments
  end

  test "should create an comment", %{socket: socket, post: post} do
    {:ok, _comments, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})

    ref = push(socket, "comment:add", %{"content" => "content_test"})

    msg = %{comment: %{content: "content_test"}}
    assert_reply ref, :ok, %{}
    broadcast_event = "comments:#{post.id}:new"

    assert_broadcast ^broadcast_event, msg
    refute is_nil(msg)
  end
end
