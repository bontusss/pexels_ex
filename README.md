# PexelsEx

[![Elixir CI](https://github.com/yourusername/pexels_ex/workflows/Elixir%20CI/badge.svg)](https://github.com/yourusername/pexels_ex/actions)

PexelsEx is an Elixir SDK for the Pexels API. It provides a simple interface to search for photos and videos, get curated content, and access featured collections.

## Installation

Add `pexels_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:pexels_ex, "~> 0.1.0"}
  ]
end
```

## Configuration

Set your Pexels API key in your config:

```elixir
config :pexels_ex, api_key: "YOUR_API_KEY"
```

Alternatively, you can set the `PEXELS_API_KEY` environment variable.

## Usage

```elixir
# Search for photos
{:ok, results} = PexelsEx.search_photos("nature", per_page: 10)

# Get curated photos
{:ok, curated} = PexelsEx.curated_photos(per_page: 15)

# Search for videos
{:ok, videos} = PexelsEx.search_videos("ocean", per_page: 5)

# Get popular videos
{:ok, popular} = PexelsEx.popular_videos(per_page: 20)

# Get featured collections
{:ok, collections} = PexelsEx.featured_collections()
```

## Documentation

Full documentation can be found at [https://hexdocs.pm/pexels_ex](https://hexdocs.pm/pexels_ex).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.