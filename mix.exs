defmodule MiaClient.Mixfile do
  use Mix.Project

  def project do
    [ app: :mia_client,
      version: "0.0.1",
      elixir: "~> 0.10.1-dev",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    []
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "~> 0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [
      { :socket, "~> 0.1", github: "meh/elixir-socket" }
    ]
  end
end
