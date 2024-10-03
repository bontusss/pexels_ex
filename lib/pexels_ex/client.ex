defmodule PexelsEx.Client do
  @moduledoc """
  A client for interacting with the Pexels API.

  This module provides functions to make HTTP requests to the Pexels API,
  including processing URLs, request headers, and response bodies.
  """

  use HTTPoison.Base

  @base_url "https://api.pexels.com"

  @doc """
  Processes the given URL by appending it to the base URL.

  ## Examples

      iex> PexelsEx.Client.process_url("/v1/search")
      "https://api.pexels.com/v1/search"
  """
  def process_url(url) do
    @base_url <> url
  end

  @doc """
  Processes the request headers by adding the Authorization header with the API key.

  The API key is fetched from the environment variable `PEXELS_API_KEY` or from the application configuration.

  ## Examples

      iex> PexelsEx.Client.process_request_headers([])
      [{"Authorization", "your_api_key"}]
  """
  def process_request_headers(headers) do
    api_key = System.get_env("PEXELS_API_KEY") || Application.get_env(:pexel_ex, :api_key)
    [{"Authorization", api_key} | headers]
  end

  @doc """
  Processes the response body by decoding it from JSON.

  ## Examples

      iex> PexelsEx.Client.process_response_body("{\"key\": \"value\"}")
      %{"key" => "value"}
  """
  def process_response_body(body) do
    Jason.decode!(body)
  end

  @valid_params ~w(query per_page page orientation size color locale)

  @doc """
  Makes a GET request to the given URL with optional query parameters.

  Only the parameters specified in `@valid_params` are included in the query string.

  ## Parameters

    - `url`: The endpoint URL (string).
    - `params`: A keyword list of query parameters (optional).

  ## Examples

      iex> PexelsEx.Client.get("/v1/search", query: "nature", per_page: 10)
      {:ok, %{"photos" => [...]}}
  """
  def get(url, params \\ []) do
    filtered_params = Enum.filter(params, fn {key, _value} -> key in @valid_params end)
    url = url <> "?" <> URI.encode_query(filtered_params)
    case get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, {status_code, body}}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
