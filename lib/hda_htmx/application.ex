defmodule HdaHtmx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HdaHtmxWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:hda_htmx, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HdaHtmx.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: HdaHtmx.Finch},
      # Start a worker by calling: HdaHtmx.Worker.start_link(arg)
      # {HdaHtmx.Worker, arg},
      {HdaHtmx.Counter, 0},
      {HdaHtmx.Contacts, [%{name: "Joe Doe", email: "jdoe@texample.com", id: 1}]},


      # Start to serve requests, typically the last entry
      HdaHtmxWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HdaHtmx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HdaHtmxWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
