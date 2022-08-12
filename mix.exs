defmodule GoogleCloud.MixProject do
  use Mix.Project

  def project do
    [
      app: :google_cloud,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {GoogleCloud.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:jason, "~> 1.3.0"},
      {:google_api_storage, "~> 0.34.0"},
      {:goth, "~> 1.3"}
    ]
  end
end
