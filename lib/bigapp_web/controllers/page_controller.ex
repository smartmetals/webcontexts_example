defmodule BigappWeb.PageController do
  use BigappWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
