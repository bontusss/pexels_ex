defmodule PexelsEx do
  @moduledoc """
  Written by B.j Mayor <ikwecheghu@gmail.com>
  `PexelsEx` is an Elixir SDK for interacting with the Pexels API.

  This module provides functions to search and retrieve photos, videos, and collections from Pexels.
  """

  alias PexelsEx.{Client, Photo, Collection, Video}

  @doc """
  Searches for photos based on a query string.

  ## Parameters
  - `query`: The search term for photos.
  - `options`: Optional parameters for the API request.

  ## Returns
  - `{:ok, photos}` on success.
  - `{:error, reason}` on failure.
  """
  def search_photos(query, options \\ []) do
    Client.get("/v1/search", [{:query, query} | options])
    |> handle_response(&Photo.parse_many/1)
  end

  @doc """
  Retrieves curated photos.

  ## Parameters
  - `options`: Optional parameters for the API request.

  ## Returns
  - `{:ok, photos}` on success.
  - `{:error, reason}` on failure.
  """
  def curated_photos(options \\ []) do
    Client.get("/v1/curated", options)
    |> handle_response(&Photo.parse_many/1)
  end

  @doc """
  Searches for videos based on a query string.

  ## Parameters
  - `query`: The search term for videos.
  - `options`: Optional parameters for the API request.

  ## Returns
  - `{:ok, videos}` on success.
  - `{:error, reason}` on failure.
  """
  def search_videos(query, options \\ []) do
    Client.get("/videos/search", [{:query, query} | options])
    |> handle_response(&Video.parse_many/1)
  end

  @doc """
  Retrieves popular videos.

  ## Parameters
  - `options`: Optional parameters for the API request.

  ## Returns
  - `{:ok, videos}` on success.
  - `{:error, reason}` on failure.
  """
  def popular_videos(options \\ []) do
    Client.get("/videos/popular", options)
    |> handle_response(&Video.parse_many/1)
  end

  @doc """
  Retrieves featured collections.

  ## Parameters
  - `options`: Optional parameters for the API request.

  ## Returns
  - `{:ok, collections}` on success.
  - `{:error, reason}` on failure.
  """
  def featured_collections(options \\ []) do
    Client.get("/v1/collections/featured", options)
    |> handle_response(&Collection.parse_many/1)
  end

  # Private function to handle the API response.
  # It takes a tuple with the response status and the response data,
  # and a parser function to process the response data.
  # If the response is successful (`:ok`), it applies the parser function
  # to the response data and returns the result wrapped in an `:ok` tuple.
  defp handle_response({:ok, response}, parser) do
    {:ok, parser.(response)}
  end

  # Private function to handle the API response when an error occurs.
  # It takes a tuple with the error status and the error data,
  # and a parser function (which is not used in this case).
  # It simply returns the error tuple as is.
  defp handle_response({:error, _} = error, _parser) do
    error
  end
end
