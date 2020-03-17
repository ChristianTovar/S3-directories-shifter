defmodule DirectoryShifter do
  @moduledoc """
  Documentation for `DirectoryShifter`.
  """
  require Logger
  alias DirectoryShifter.Core.Aws

  @doc """
  Executes the main image migrations and removal until
  the assets are completely gone on the origin bucket.
  """
  @spec start :: any()
  def start(acc \\ 1000) do
    Logger.debug("Processed #{acc} files...")

    case Aws.get_initial_object_routes() do
      [] ->
        Logger.debug("Process completed!")

      routes ->
        routes
        |> Task.async_stream(&move_and_delete/1)
        |> Stream.run()

        start(acc + 1000)
    end
  end

  defp move_and_delete(route) do
    Aws.move_image(route)
    Aws.delete_object(route)
  end
end
