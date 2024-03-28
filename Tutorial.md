# HTMX using Elixir

## Create the Elixir Project

```elixir
mix phx.new hda_htmx --no-ecto --no-live 
```

## Update the  `HdaHtmxWeb` module like this

### Update function `router`

```elixir
 # we don't need 
 # import Phoenix.LiveView.Router
def router do
    quote do
      use Phoenix.Router, helpers: false

      # Import common connection and controller functions to use in pipelines
      import Plug.Conn
      import Phoenix.Controller
    end
  end
```

### Update function `controller`

```elixir
  # we are not going to use Layouts
  # we only use html format

  def controller do
    quote do
      use Phoenix.Controller,
        formats: [:html]

      import Plug.Conn
      import HdaHtmxWeb.Gettext

      unquote(verified_routes())
    end
  end

```
### Remove the functions `live_view` and `live_component`

```elixir
  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {HdaHtmxWeb.Layouts, :app}

      unquote(html_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(html_helpers())
    end
  end
  ```

  ### Update function `html_helpers`

  ```elixir
    # We don use the Shortcut for generating JS commands
    # alias Phoenix.LiveView.JS

  defp html_helpers do
    quote do
      # HTML escaping functionality
      import Phoenix.HTML
      # Core UI components and translation
      import HdaHtmxWeb.CoreComponents
      import HdaHtmxWeb.Gettext


      # Routes generation with the ~p sigil
      unquote(verified_routes())
    end
  end

```

## Update module `HdaHtmxWeb.Router`

### Update `pipeline :browser` like this

```elixir
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end
``` 

## Remove the module `HdaHtmxWeb.Layouts` and the directory `layouts`
from `components\layout` since we are not going to use Layouts in this experiment.


## Update the template for the home like this

```html
<!DOCTYPE html>
<html lang="en" class="[scrollbar-gutter:stable]">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="csrf-token" content={get_csrf_token()} />
    <.live_title suffix=" · Phoenix Framework">
      <%= assigns[:page_title] || "HdaHtmx" %>
    </.live_title>
    <link phx-track-static rel="stylesheet" href={~p"/assets/app.css"} />
    <script defer phx-track-static type="text/javascript" src={~p"/assets/app.js"}>
    </script>
  </head>
  <body class="bg-white antialiased">
      Initial Setup
  </body>
</html>
```

## Finally update the controller  `HdaHtmxWeb.PageController`

```elixir
defmodule HdaHtmxWeb.PageController do
  use HdaHtmxWeb, :controller

  # we are not using Layouts
  plug(:put_layout, false)

  def home(conn, _params) do
    render(conn, :home)
  end
end
```

Now we are ready to launch the initial setup.

```
mix phx.server
```


