defmodule PropWeb.PageController do
  use PropWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
