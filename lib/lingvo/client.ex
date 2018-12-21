defmodule Lingvo.Client do
  @moduledoc """
  Client requests
  """

  @type api_key :: {:api_key, String.t()}
  @type path :: String.t()

  @doc """
  Performs a GET request

  ## Examples

      iex> Lingvo.Client.get("/v1/Transalation", access_token)
      {:ok, %HTTPoison.Response{}}

  """
  @spec get(path, String.t()) :: {}

  def get(path, access_token) do
    case HTTPoison.get(base_uri() <> path, bearer_headers(access_token), options()) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 400, body: body}} -> {:error, body}
      {:ok, %HTTPoison.Response{status_code: 404}} -> {:error, "Page not found"}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
      _ -> {:error, "Unknown error"}
    end
  end

  @doc """
  Performs a POST request

  ## Examples

      iex> Lingvo.Client.post("/v1.1/authenticate")
      {:ok, ""}

  """
  @spec post(path) :: {:ok, api_key}

  def post(path) do
    case HTTPoison.post(base_uri() <> path, "", basic_headers(), options()) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %HTTPoison.Response{status_code: 400, body: body}} -> {:error, body}
      {:ok, %HTTPoison.Response{status_code: 404}} -> {:error, "Page not found"}
      {:error, %HTTPoison.Error{reason: reason}} -> {:error, reason}
      _ -> {:error, "Unknown error"}
    end
  end

  defp base_uri, do: "https://developers.lingvolive.com/api"

  defp basic_headers, do: [{"Authorization", "Basic #{api_key()}"}, {"Accept", "Application/json; Charset=utf-8"}, {"Content-Type", "application/json"}]

  defp bearer_headers(access_token), do: [{"Authorization", "Bearer #{access_token}"}, {"Accept", "Application/json; Charset=utf-8"}, {"Content-Type", "application/json"}]

  defp api_key, do: Application.get_env(:lingvo, :api_key) || ""

  defp options, do: [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 500]
end
