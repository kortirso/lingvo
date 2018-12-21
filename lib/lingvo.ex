defmodule Lingvo do
  @moduledoc """
  Elixir client for ABBYY Lingvo API

  ## Configuration
  An API key can be set in your application's config.

      config :lingvo, api_key: "LINGVO_API_KEY"

  """

  alias Lingvo.Client

  @type api_key :: String.t()

  @available_locales [ch: 1028, da: 1030, de: 1031, el: 1032, en: 1033, es: 1034, fr: 1036, it: 1040, kk: 1087, la: 1142, pl: 1045, ru: 1049, tt: 1092, uk: 1058]
  @available_translations ["ch-ch", "ch-ru", "da-ru", "de-ru", "el-ru", "en-en", "en-ru", "en-uk", "es-ru", "fr-ru", "it-ru", "kk-ru", "la-ru", "pl-ru", "pl-uk", "ru-ch", "ru-da", "ru-de", "ru-el", "ru-en", "ru-es", "ru-fr", "ru-it", "ru-kk", "ru-ru", "ru-tt", "ru-uk", "tt-ru", "uk-en", "uk-pl", "uk-ru", "uk-uk"]

  @doc """
  Get API token. Token must be used in Bearer Authorization header in every translation API request.

  ## Examples

      iex> Lingvo.authenticate
      {:ok, "access_token"}

  """
  @spec authenticate :: {:ok, api_key}

  def authenticate do
    Client.post("/v1.1/authenticate")
  end

  @doc """
  Translation for the word or phrase. Searches only in specified direction.

  ## Examples

      iex> Lingvo.translate([text: "Hola", from: "es", to: "ru"], access_token)
      {
        :ok,
        %{
          [
            "ArticleId" => "Universal (Es-Ru)__hola",
            ...
          ]
        }
      }

  ## Options

      text - Word or phrase to translate, required
      from - Source language, required
      to - Target language, required
      case_sensitivity - If you need case-sensitive search then just add any value, optional, default is false

  """
  @spec translate([tuple], String.t()) :: String.t()

  def translate(options, access_token) when is_list(options) and is_binary(access_token) do
    [text, from, to, case_sensitivity] = read_options(options)
    cond do
      is_nil(text) -> {:error, "Text is required field"}
      is_nil(from) -> {:error, "From is required field"}
      is_nil(to) -> {:error, "To is required field"}
      !Keyword.has_key?(@available_locales, String.to_atom(from)) -> {:error, "Source language is not available"}
      !Keyword.has_key?(@available_locales, String.to_atom(to)) -> {:error, "Destination language is not available"}
      !Enum.member?(@available_translations, "#{from}-#{to}") -> {:error, "Translation is not available"}
      true -> do_translate(text, from, to, case_sensitivity, access_token)
    end
  end

  defp read_options(options) do
    [
      Keyword.get(options, :text),
      Keyword.get(options, :from),
      Keyword.get(options, :to),
      Keyword.get(options, :case_sensitivity)
    ]
  end

  defp do_translate(text, from, to, case_sensitivity, access_token) do
    url_for_translate(text, from, to, case_sensitivity)
    |> Client.get(access_token)
    |> parse_response()
  end

  defp url_for_translate(text, from, to, case_sensitivity) do
    url = "/v1/Translation?text=#{text}&srcLang=#{get_code(from)}&dstLang=#{get_code(to)}"
    if !is_nil(case_sensitivity), do: url <> "&isCaseSensitive=true", else: url
  end

  defp parse_response(response) do
    case response do
      {:ok, body} -> {:ok, Poison.Parser.parse!(body)}
      {:error, body} -> {:error, body}
    end
  end

  defp get_code(string), do: Keyword.get(@available_locales, String.to_atom(string))
end
