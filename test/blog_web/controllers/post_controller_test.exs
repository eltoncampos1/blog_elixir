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

  def fixture(:post) do
    user = Blog.Accounts.get_user!(1)

    {:ok, post} = Blog.Posts.create_post(user, @valid_post)
    post
  end

  test "List all posts", %{conn: conn} do
    user = Blog.Accounts.get_user!(1)

    Blog.Posts.create_post(user, @valid_post)
    conn = get(conn, Routes.post_path(conn, :index))
    assert html_response(conn, 200) =~ "teste"
  end

  test "Get post by id", %{conn: conn} do
    user = Blog.Accounts.get_user!(1)

    {:ok, post} = Blog.Posts.create_post(user, @valid_post)
    conn = get(conn, Routes.post_path(conn, :show, post))
    assert html_response(conn, 200) =~ "teste"
  end

  test "Render form to create a new post", %{conn: conn} do
    conn =
    conn
    |>Plug.Test.init_test_session(user_id: 1)
    |> get(Routes.post_path(conn, :new))
    assert html_response(conn, 200) =~ "Title"
  end

  test "create a new post", %{conn: conn} do
    conn =
    conn
    |> Plug.Test.init_test_session(user_id: 1)
    |> post(Routes.post_path(conn, :create), post: @valid_post)

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == Routes.post_path(conn, :show, id)

    conn = get(conn, Routes.post_path(conn, :show, id))
    assert html_response(conn, 200) =~ "teste"
  end

  test "create a new post with invalid params", %{conn: conn} do
    conn =
    conn
    |> Plug.Test.init_test_session(user_id: 1)
    |>post(Routes.post_path(conn, :create), post: %{})

    assert html_response(conn, 200) =~ "can&#39;t be blank"
  end

  describe "depends on posts created" do
    setup [:create_post]

    test "Render form to edit an post", %{conn: conn} do
      user = Blog.Accounts.get_user!(1)
      {:ok, post} = Blog.Posts.create_post(user, @valid_post)
      conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> get(Routes.post_path(conn, :edit, post))

      assert html_response(conn, 200) =~ "a"
    end

    test "edit an post", %{conn: conn, post: post} do
      conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |>put(Routes.post_path(conn, :update, post), post: @updated_post)
      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.post_path(conn, :show, id)

      conn = get(conn,Routes.post_path(conn, :show, id))
      assert html_response(conn, 200) =~ "desc_test_updated"
    end

    test "edit an post with invalid params", %{conn: conn, post: post} do
      conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |>put(Routes.post_path(conn, :update, post), post: %{title: nil, description: nil})

      assert html_response(conn, 200) =~ "can&#39;t be blank"
    end

    test "delete post", %{conn: conn, post: post} do
      conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |>delete(Routes.post_path(conn, :delete, post))

      assert redirected_to(conn) == Routes.post_path(conn, :index)
      assert_error_sent 404, fn -> get(conn, Routes.post_path(conn, :show, post)) end
    end
  end

  defp create_post(_), do: %{post: fixture(:post)}
end
