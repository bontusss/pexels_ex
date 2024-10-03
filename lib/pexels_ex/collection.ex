defmodule PexelsEx.Collection do
  @moduledoc """
  Struct and parsing functions for Pexels collections.
  """

  defstruct [:id, :title, :description, :private, :media_count]

  def parse(collection) do
    %__MODULE__{
      id: collection["id"],
      title: collection["title"],
      description: collection["description"],
      private: collection["private"],
      media_count: collection["media_count"]
    }
  end

  def parse_many(response) do
    %{
      page: response["page"],
      per_page: response["per_page"],
      collections: Enum.map(response["collections"], &parse/1)
    }
  end
end
