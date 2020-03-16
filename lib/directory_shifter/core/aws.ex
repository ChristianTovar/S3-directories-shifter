defmodule DirectoryShifter.Core.Aws do
  @moduledoc """
  Contains AWS S3 support for working with buckets.
  """

  @doc """
  Returns a list with the first 1000 objects from the bucket.
  """
  @spec get_initial_objects :: [String.t()]
  def get_initial_objects do
    origin_bucket()
    |> ExAws.S3.list_objects(max_keys: 1000)
    |> ExAws.request()
    |> extract_only_route()
  end

  @doc """
  Returns an in-memory image from the origin bucket by the specified route.
  """
  @spec get_object(String.t()) :: binary()
  def get_object(route) do
    origin_bucket()
    |> ExAws.S3.get_object(route)
    |> ExAws.request()
    |> extract_only_object()
  end

  defp extract_only_route({:ok, %{body: %{contents: contents}}}) do
    Enum.map(contents, fn %{key: route} -> route end)
  end

  defp extract_only_object({:ok, %{body: image}}), do: image
  defp extract_only_object({:error, _}), do: nil

  defp origin_bucket, do: Application.fetch_env!(:directory_shifter, :origin_bucket)
  defp destiny_bucket, do: Application.fetch_env!(:directory_shifter, :destiny_bucket)
end
