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
      image: "auth.info.image",
    },
    provider: "google"
  }

  test "callback success", %{conn: conn} do
    conn =
    conn
    |>assign(:ueberauth_auth, @ueberauth)
    |>get(Routes.auth_path(conn, :callback, "google"))
    assert redirected_to(conn) == Routes.page_path(conn, :index)
    conn = get(conn, Routes.page_path(conn, :index))
    assert html_response(conn, 200) =~  "Welcome!!! #{@ueberauth.info.email} "
  end
end
