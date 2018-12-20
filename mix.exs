defmodule Lingvo.MixProject do
  use Mix.Project

  @description """
    Elixir client for ABBYY Lingvo API
  """

  def project do
    [
      app: :lingvo,
      version: "0.0.1",
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
