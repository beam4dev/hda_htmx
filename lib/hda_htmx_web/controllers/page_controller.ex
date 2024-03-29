defmodule HdaHtmxWeb.PageController do
  use HdaHtmxWeb, :controller

  # we are not using Layouts
  plug(:put_layout, false)

  def home(conn, _params) do
    contacts = HdaHtmx.Contacts.contacts()
    render(conn, :home, contacts: contacts)
  end



  def contact(conn, params) do
    # retrieve the values from the form.
    name = params["name"]
    email = params["email"]

    HdaHtmx.Contacts.add(%{name: name, email: email})

    contacts = HdaHtmx.Contacts.contacts()
     # Redirect or render a template when you're done
    conn
     |> render(:_display, contacts: contacts)
  end
end
