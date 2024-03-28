defmodule HdaHtmxWeb.PageController do
  use HdaHtmxWeb, :controller

  # we are not using Layouts
  plug(:put_layout, false)

  def home(conn, _params) do
    render(conn, :home)
  end
end
