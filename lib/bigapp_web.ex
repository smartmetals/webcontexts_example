defmodule BigappWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use BigappWeb, :controller
      use BigappWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: BigappWeb
      import Plug.Conn
      import BigappWeb.Router.Helpers
      import BigappWeb.Gettext
    end
  end

  def view(opts \\
    [root: "lib/bigapp_web/templates",
     namespace: BigappWeb]) do
    quote do
      use Phoenix.View, unquote(opts)

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import BigappWeb.Router.Helpers
      import BigappWeb.ErrorHelpers
      import BigappWeb.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import BigappWeb.Gettext
    end
  end

  @webdir "bigapp_web"

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(:view) do
    view_path =
      __CALLER__.file
      |> String.split(@webdir)
      |> List.last
      |> Path.dirname
    templates = "lib/#{@webdir <> view_path}/templates"
    apply(__MODULE__, :view, [[root: templates,
                               namespace: __CALLER__.module,
                               pattern: "**/*"]])
  end
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
