defmodule BlogWeb.PostControllerTest do
  @moduledoc """
  Post_controller tests
  """

  use BlogWeb.ConnCase

  @valid_post %{
    title: "teste",
    description: "desc_test"
  }

  test "List all posts", %{conn: conn} do
    Blog.Posts.create_post(@valid_post)
    conn = get(conn, Routes.post_path(conn, :index))
    assert html_response(conn, 200) =~ "teste"
  end

  test "Get post by id", %{conn: conn} do
    {:ok, post} = Blog.Posts.create_post(@valid_post)
    conn = get(conn, Routes.post_path(conn, :show, post))
    assert html_response(conn, 200) =~ "teste"
  end

  test "Render form to create a new post", %{conn: conn} do
    conn = get(conn, Routes.post_path(conn, :new))
    assert html_response(conn, 200) =~ "Title"
  end

  test "create a new post", %{conn: conn} do
    conn = post(conn, Routes.post_path(conn, :create), post: @valid_post)
    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.post_path(conn, :show, id)

    conn = get(conn, Routes.post_path(conn, :show, id))
    assert html_response(conn, 200) =~ "teste"
  end
end
