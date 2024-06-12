defmodule ChirperPhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ChirperPhoenixWeb.Telemetry,
      ChirperPhoenix.Repo,
      {DNSCluster, query: Application.get_env(:chirper_phoenix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ChirperPhoenix.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ChirperPhoenix.Finch},
      # Start a worker by calling: ChirperPhoenix.Worker.start_link(arg)
      # {ChirperPhoenix.Worker, arg},
      # Start to serve requests, typically the last entry
      ChirperPhoenixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ChirperPhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ChirperPhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
