defmodule PexelsEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :pexels_ex,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "An Elixir SDK for the pexels API",
      name: "PexelsEx",
      source_url: "https://github.com/bontusss/pexels_ex",
      package:  package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 2.0"},
      {:jason, "~> 1.2"},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:mock, "~> 0.3.0", only: :test}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/bontusss/pexels_ex"}
    ]
  end
end
