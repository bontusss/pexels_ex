defmodule PexelsExTest do
  use ExUnit.Case
  import Mock

  describe "search_photos/2" do
    test "returns photos when successful" do
      mock_response = %{
        "total_results" => 1,
        "page" => 1,
        "per_page" => 1,
        "photos" => [
          %{
            "id" => 1,
            "width" => 100,
            "height" => 100,
            "url" => "https://example.com/photo.jpg",
            "photographer" => "John Doe",
            "photographer_url" => "https://example.com/johndoe",
            "photographer_id" => 67890,
            "avg_color" => "#AABBCC",
            "src" => %{"original" => "https://example.com/photo.jpg"},
            "liked" => true,
            "alt" => "A beautiful scenery"
          }
        ]
      }

      with_mock PexelsEx.Client, get: fn _, _ -> {:ok, mock_response} end do
        assert {:ok, result} = PexelsEx.search_photos("nature")
        assert result.total_results == 1
        assert length(result.photos) == 1
        photo = hd(result.photos)
        assert photo.id == 1
        assert photo.photographer == "John Doe"
      end
    end
  end

  test "returns error when request fails" do
    with_mock PexelsEx.Client, get: fn _, _ -> {:error, "API Error"} end do
      assert {:error, "API Error"} = PexelsEx.search_photos("nature")
    end
  end

  # Add similar tests for other functions (curated_photos, search_videos, popular_videos, featured_collections)
end
