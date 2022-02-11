defmodule BlogWeb.AuthControllerTest do
  @moduledoc """
  AuthControllerTest module
  """
  use BlogWeb.ConnCase

  @ueberauth %Ueberauth.Auth{
    credentials: %{
      token: "123"
    },
    info: %{
      email: "auth.info@email",
      first_name: "auth.info.first_name",
      image: "auth.info.image"
    },
    provider: "google"
  }

  @ueberauth_error %Ueberauth.Auth{
    credentials: %{
      token: nil
    },
    info: %{
      email: "adsd@asd",
      first_name: nil,
      image: nil
    },
    provider: "google"
  }

  test "callback success", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth)
      |> get(Routes.auth_path(conn, :callback, "google"))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Welcome!!! #{@ueberauth.info.email} "
  end

  test "callback error", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth_error)
      |> get(Routes.auth_path(conn, :callback, "google"))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~ "Something wrong"
  end

  test "logout", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> get(Routes.auth_path(conn, :logout))

    assert redirected_to(conn) == Routes.page_path(conn, :index)
  end
end
