defmodule BlogWeb.PostControllerTest do
  @moduledoc """
  Post_controller tests
  """

  use BlogWeb.ConnCase

  @valid_post %{
    title: "teste",
    description: "desc_test"
  }

  @updated_post %{
    title: "teste",
    description: "desc_test_updated"
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

  test "create a new post with invalid params", %{conn: conn} do
    conn = post(conn, Routes.post_path(conn, :create), post: %{})

    assert html_response(conn, 200) =~ "can&#39;t be blank"
  end

  test "Render form to edit an post", %{conn: conn} do
    {:ok, post} = Blog.Posts.create_post(@valid_post)

    conn = get(conn, Routes.post_path(conn, :edit, post))
    assert html_response(conn, 200) =~ "desc_test"
    assert html_response(conn, 200) =~ "teste"
  end

  test "edit an post", %{conn: conn} do
    {:ok, post} = Blog.Posts.create_post(@valid_post)

    conn = put(conn, Routes.post_path(conn, :update, post), post: @updated_post)
    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.post_path(conn, :show, id)

    conn = get(conn, Routes.post_path(conn, :show, id))
    assert html_response(conn, 200) =~ "desc_test_updated"
  end

  test "edit an post with invalid params", %{conn: conn} do
    {:ok, post} = Blog.Posts.create_post(@valid_post)
    conn = put(conn, Routes.post_path(conn, :update, post), post: %{title: nil, description: nil})

    assert html_response(conn, 200) =~ "can&#39;t be blank"
  end
end
