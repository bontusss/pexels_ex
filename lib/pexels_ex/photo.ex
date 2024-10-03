defmodule PexelsEx.Photo do
  @moduledoc """
  This module defines a struct and functions for parsing photo data from the Pexels API.

  ## Struct Fields

    - `:id` - The unique identifier for the photo.
    - `:width` - The width of the photo in pixels.
    - `:height` - The height of the photo in pixels.
    - `:url` - The URL to the photo's page on Pexels.
    - `:photographer` - The name of the photographer.
    - `:photographer_url` - The URL to the photographer's profile on Pexels.
    - `:src` - A map containing URLs to different sizes of the photo.

  ## Example

      iex> photo = %PexelsEx.Photo{
      ...>   id: 12345,
      ...>   width: 1920,
      ...>   height: 1080,
      ...>   url: "https://www.pexels.com/photo/12345",
      ...>   photographer: "John Doe",
      ...>   photographer_url: "https://www.pexels.com/@johndoe",
      ...>   photographer_id: 67890,
      ...>   avg_color: "#AABBCC",
      ...>   src: %{"original" => "https://images.pexels.com/photos/12345/original.jpg"},
      ...>   liked: true,
      ...>   alt: "A beautiful scenery"
      ...> }
  """

  defstruct [
    :id,
    :width,
    :height,
    :url,
    :photographer,
    :photographer_url,
    :photographer_id,
    :avg_color,
    :src,
    :liked,
    :alt
  ]

  @doc """
  Parses a single photo map into a `%PexelsEx.Photo{}` struct.

  ## Parameters

    - `photo` - A map representing a photo, typically from the Pexels API response.

  ## Returns

    - A `%PexelsEx.Photo{}` struct populated with the data from the input map.

  ## Example

      iex> photo_map = %{
      ...>   "id" => 12345,
      ...>   "width" => 1920,
      ...>   "height" => 1080,
      ...>   "url" => "https://www.pexels.com/photo/12345",
      ...>   "photographer" => "John Doe",
      ...>   "photographer_url" => "https://www.pexels.com/@johndoe",
      ...>   "photographer_id" => 67890,
      ...>   "avg_color" => "#AABBCC",
      ...>   "src" => %{"original" => "https://images.pexels.com/photos/12345/original.jpg"},
      ...>   "liked" => true,
      ...>   "alt" => "A beautiful scenery"
      ...> }
      iex> PexelsEx.Photo.parse(photo_map)
      %PexelsEx.Photo{
        id: 12345,
        width: 1920,
        height: 1080,
        url: "https://www.pexels.com/photo/12345",
        photographer: "John Doe",
        photographer_url: "https://www.pexels.com/@johndoe",
        photographer_id: 67890,
        avg_color: "#AABBCC",
        src: %{"original" => "https://images.pexels.com/photos/12345/original.jpg"},
        liked: true,
        alt: "A beautiful scenery"
      }
  """
  def parse(photo) do
    %__MODULE__{
      id: photo["id"],
      width: photo["width"],
      height: photo["height"],
      url: photo["url"],
      photographer: photo["photographer"],
      photographer_url: photo["photographer_url"],
      photographer_id: photo["photographer_id"],
      avg_color: photo["avg_color"],
      src: photo["src"],
      liked: photo["liked"],
      alt: photo["alt"]
    }
  end

  @doc """
  Parses a response map containing multiple photos into a map with metadata and a list of `%PexelsEx.Photo{}` structs.

  ## Parameters

    - `response` - A map representing the response from the Pexels API, containing multiple photos and metadata.

  ## Returns

    - A map with the following keys:
      - `:total_results` - The total number of results available.
      - `:page` - The current page number.
      - `:per_page` - The number of results per page.
      - `:photos` - A list of `%PexelsEx.Photo{}` structs parsed from the response.

  ## Example

      iex> response_map = %{
      ...>   "total_result" => 100,
      ...>   "page" => 1,
      ...>   "
  """
  def parse_many(response) do
    %{
      total_results: response["total_results"],
      page: response["page"],
      per_page: response["per_page"],
      next_page: response["next_page"],
      prev_page: response["prev_page"],
      photos: Enum.map(response["photos"], &parse/1)
    }
  end
end
