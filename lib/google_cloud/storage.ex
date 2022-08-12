defmodule GoogleCloud.Storage do
  @moduledoc """
  Documentation for Google Cloud Storage
  """

  require Logger

  @bucket_id "temp"

  @doc """
  Uploads file
  ## Examples
  iex> GoogleCloud.Storage.upload_file("test/file.txt")
  {:ok, media}
  """
  @spec upload_file(file_path :: String.t(), name :: String.t()) :: {:ok, any()} | {:error, any()}
  def upload_file(file_path, name \\ nil) do
    # Authenticate.
    {:ok, token} = Goth.fetch(GoogleCloud.Goth)
    conn = GoogleApi.Storage.V1.Connection.new(token.token)

    object_name = if is_nil(name), do: Path.basename(file_path), else: name

    # Make the API request.
    case GoogleApi.Storage.V1.Api.Objects.storage_objects_insert_simple(
           conn,
           @bucket_id,
           "multipart",
           %{name: object_name},
           file_path
         ) do
      {:ok, object} ->
        Logger.info("Uploaded #{object.name}")
        {:ok, object}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
