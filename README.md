# Lingvo

Elixir client for ABBYY Lingvo API

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `lingvo` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:lingvo, "~> 0.9.0"}
  ]
end
```

## Using

### Get access token

An API key can be set in your application's config.
```elixir
  config :lingvo, api_key: "LINGVO_API_KEY"
```

Then make request for getting access_token
```elixir
  Lingvo.authenticate
```

### Translate word or phrase

An API key can be set in your application's config.

```elixir
  Lingvo.translate([text: "Hola", from: "es", to: "ru"], access_token)
```
  text - Word or phrase to translate, required
  from - Source language, ISO 639-1 format, required
  to - Target language, ISO 639-1 format, required
  case_sensitivity - If you need case-sensitive search then just add any value, optional, default is false
  access_token - Access token from authentication, required

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kortirso/lingvo.

## License

The package is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Disclaimer

Use this package at your own peril and risk.

## Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/learn_kit](https://hexdocs.pm/learn_kit).
