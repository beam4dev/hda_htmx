defmodule HdaHtmxWeb.PageController do
  use HdaHtmxWeb, :controller

  # we are not using Layouts
  plug(:put_layout, false)

  def home(conn, _params) do
    count = HdaHtmx.Counter.value()
    render(conn, :home, count: count)
  end


  def count(conn, _params) do
    HdaHtmx.Counter.inc()
    count = HdaHtmx.Counter.value()
    render(conn, :_counter, count: count)
  end
end
