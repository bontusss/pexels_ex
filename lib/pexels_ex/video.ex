defmodule PexelsEx.Video do
  defstruct [:id, :width, :height, :url, :image, :duration, :user, :video_files]

  def parse(video) do
    %__MODULE__{
      id: video["id"],
      width: video["width"],
      height: video["video"],
      url: video["url"],
      image: video["image"],
      duration: video["duration"],
      user: video["user"],
      video_files: video["video_files"]
    }
  end

  def parse_many(response) do
    %{
      total_results: response["total_response"],
      page: response["page"],
      per_page: response["per_page"],
      videos: Enum.map(response["videos"], &parse/1)
    }
  end
end
