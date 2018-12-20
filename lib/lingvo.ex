defmodule Lingvo do
  @moduledoc """
  Elixir client for ABBYY Lingvo API

  ## Configuration
  An API key can be set in your application's config.

      config :lingvo, api_key: "LINGVO_API_KEY"

  """

  @type api_key :: {:api_key, String.t()}
  @type path :: String.t()

  @doc """
  Performs a GET request

  ## Examples

      iex> Lingvo.get("/v1/Transalation")
      {:ok, _}

  """

  def get(path) do
    HTTPoison.get(base_uri() <> path, bearer_headers(), options())
  end

  @doc """
  Performs a POST request

  ## Examples

      iex> Lingvo.post("/v1.1/authenticate")
      {:ok, "access_token"}

  """
  @spec post(path) :: {:ok, api_key}

  def post(path) do
    HTTPoison.post(base_uri() <> path, "", basic_headers(), options())
  end

  defp base_uri, do: "https://developers.lingvolive.com/api"

  defp basic_headers, do: [{"Authorization", "Basic #{api_key()}"}, {"Accept", "Application/json; Charset=utf-8"}, {"Content-Type", "application/json"}]

  defp bearer_headers, do: [{"Authorization", "Bearer #{api_key()}"}, {"Accept", "Application/json; Charset=utf-8"}, {"Content-Type", "application/json"}]

  defp api_key, do: Application.get_env(:lingvo, :api_key) || ""

  defp options, do: [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]
end
