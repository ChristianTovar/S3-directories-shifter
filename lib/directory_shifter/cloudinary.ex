defmodule DirectoryShifter.Cloudinary do
  @moduledoc """
  Contains interactions with the Cloudinary API.
  """

  @doc """
  Returns a tuple with a list of assets from the Cloudinary instance, as
  well as the next cursor for fetching the next paginated response.
  """
  @spec get_resources(Keyword.t()) :: {:error, String.t()} | {:ok, String.t(), [map()]}
  def get_resources(options) do
    case Cloudinex.resources(options) do
      {:error, reason} ->
        {:error, reason}

      {:ok, %{"next_cursor" => next_cursor, "resources" => resources}} ->
        {:ok, next_cursor, resources}
    end
  end
end
