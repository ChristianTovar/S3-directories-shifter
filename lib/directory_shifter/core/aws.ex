defmodule DirectoryShifter.Core.Aws do
  @moduledoc """
  Contains AWS S3 support for working with buckets.
  """

  @doc """
  Returns a list with the first 1000 objects from the bucket.
  """
  @spec get_initial_object_routes :: [String.t()]
  def get_initial_object_routes do
    origin_bucket()
    |> ExAws.S3.list_objects(max_keys: 1000)
    |> ExAws.request()
    |> extract_only_route()
  end

  @doc """
  Copies the source image into the destiny bucket under the new specified route.
  """
  @spec move_image(String.t()) :: {:ok, map()} | {:error, map()}
  def move_image(origin_route) do
    destiny_route = create_destiny_route(origin_route)

    ExAws.S3.put_object_copy(
      destiny_bucket(),
      destiny_route,
      origin_bucket(),
      origin_route
    )
    |> ExAws.request()
  end

  defp extract_only_route({:ok, %{body: %{contents: contents}}}) do
    Enum.map(contents, fn %{key: route} -> route end)
  end

  defp create_destiny_route(route) do
    extension = Regex.run(~r/\.\w*/, route) |> Enum.at(0)
    folder_name = Regex.run(~r/\d*\.\w{3}/, route) |> Enum.at(0) |> String.replace(~r/\.\w{3}/, "")

    file_name =
      Regex.run(~r/\/upload\/\w*/, route) |> Enum.at(0) |> String.replace(~r/\/upload\//, "")

    "image/upload/v#{folder_name}/#{file_name <> extension}"
  end

  defp origin_bucket, do: Application.fetch_env!(:directory_shifter, :origin_bucket)
  defp destiny_bucket, do: Application.fetch_env!(:directory_shifter, :destiny_bucket)
end
