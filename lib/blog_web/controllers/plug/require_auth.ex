defmodule BlogWeb.Plug.RequireAuth do
  @moduledoc """
  Plug.RequireAuth module
  """
  import Plug.Conn
  use BlogWeb, :controller

  def init(_), do: nil

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You are not logged in.")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
