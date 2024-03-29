defmodule HdaHtmxWeb.PageController do
  use HdaHtmxWeb, :controller

  # we are not using Layouts
  plug(:put_layout, false)

  def home(conn, _params) do
    contacts = HdaHtmx.Contacts.contacts()
    render(conn, :home, contacts: contacts, data: %{values: %{name: "", email: ""}, errors: %{email: ""}})
  end



  def contact(conn, params) do
    # retrieve the values from the form.
    name = params["name"]
    email = params["email"]

    contacts = HdaHtmx.Contacts.contacts()

    case  Enum.any?(contacts, fn item -> item.email === email end) do
      true ->
        values = %{name: name, email: email}
        errors = %{email: "Email already exist"}
        conn
        |> put_status(:unprocessable_entity )
        |> render(:_form, values: values, errors: errors)

      _ ->
        id = Enum.count(HdaHtmx.Contacts.contacts())
        HdaHtmx.Contacts.add(%{name: name, email: email, id: id})
        contacts = HdaHtmx.Contacts.contacts()
        # Redirect or render a template when you're done
       conn
        |> render(:_display, contacts: contacts)
    end

  end



end
