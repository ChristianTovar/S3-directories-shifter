defmodule DirectoryShifter.MixProject do
  use Mix.Project

  def project do
    [
      app: :directory_shifter,
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {DirectoryShifter.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.3"},
      {:hackney, "~> 1.15.2"},
      {:jason, ">= 1.0.0"},
      {:ex_aws, "~> 2.0"},
      {:ex_aws_s3, "~> 2.0"},
      {:sweet_xml, "~> 0.6"},
      {:benchee, "~> 1.0", only: :dev}
    ]
  end
end
