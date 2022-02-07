defmodule BlogWeb.CommentsChannelTest do
  @moduledoc """
  Comments websocket channel test
  """

  use BlogWeb.ChannelCase
  alias BlogWeb.UserSocket
  alias Blog.Posts

  @valid_post %{
    title: "teste_title",
    description: "test_desc"
  }

  test "should connect to socket" do

    {:ok, post} = Posts.create_post(@valid_post)
    {:ok, socket} = connect(UserSocket, %{})

    {:ok, comments, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})

   assert post.id == socket.assigns.post_id
   assert [] == comments.comments
  end

end
