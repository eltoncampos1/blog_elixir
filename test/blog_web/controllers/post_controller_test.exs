defmodule BlogWeb.PostControllerTest do
  @moduledoc """
  Post_controller tests
  """

  use BlogWeb.ConnCase

  @valid_post %{
    title: "teste",
    description: "desc_test"
  }

  test "LIst all posts", %{conn: conn} do
    Blog.Posts.create_post(@valid_post)
    conn = get(conn, Routes.post_path(conn, :index))
    assert html_response(conn, 200) =~ "teste"
  end
end
