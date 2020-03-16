defmodule DirectoryShifter.Core.Aws do
  @moduledoc """
  Contains AWS S3 support for working with buckets.
  """

  @doc """
  Returns a list with the first 1000 objects from the bucket.
  """
  @spec get_initial_objects(String.t()) :: [String.t()]
  def get_initial_objects(bucket) do
    bucket
    |> ExAws.S3.list_objects(max_keys: 1000)
    |> ExAws.request()
    |> extract_only_route()
  end

  defp extract_only_route({:ok, %{body: %{contents: contents}}}) do
    Enum.map(contents, fn %{key: route} -> route end)
  end
end
