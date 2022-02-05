defmodule BlogWeb.CommentsChannel do
  @moduledoc """
  Comments channel for websockets
  """
  use BlogWeb, :channel

  @impl true
  def join("comments:" <> post_id, payload, socket) do
    post = Blog.Posts.get_post_with_comments(post_id)
    {:ok, %{comments: post.comments}, assign(socket, :post_id, post.id)}
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("comment:add", content, socket) do
    response = socket.assigns.post_id
    |> Blog.Comments.create_comment(content)

    IO.inspect response
    {:reply, {:ok, content}, socket}
  end

end
