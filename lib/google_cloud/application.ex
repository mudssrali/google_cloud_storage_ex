defmodule GoogleCloud.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    credentials = "GCP_CREDENTIALS" |> System.fetch_env!() |> Jason.decode!()
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    source = {:service_account, credentials, scopes: scopes}

    children = [
      # Start Goth
      {Goth, name: GoogleCloud.Goth, source: source}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GoogleCloud.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
