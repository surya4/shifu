defmodule Shifu.App do
  use Application

  def start(_type, _args) do
    children = [
      Shifu.Repo,
      ShifuWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Shifu.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ShifuWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
