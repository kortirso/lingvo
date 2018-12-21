defmodule Lingvo.MixProject do
  use Mix.Project

  @description """
    Elixir client for ABBYY Lingvo API
  """

  def project do
    [
      app: :lingvo,
      version: "0.9.0",
      elixir: "~> 1.7",
      name: "Lingvo",
      description: @description,
      source_url: "https://github.com/kortirso/lingvo",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.4"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.19", only: :dev}
    ]
  end

  defp package do
    [
      maintainers: ["Anton Bogdanov"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kortirso/lingvo"}
    ]
  end
end
