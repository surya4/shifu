defmodule Shifu.Helpers.Files do
  def get_storage_file_path(file_name) do
    file_directory = Application.get_env(:shifu, :storage_upload_path)
    Path.join([file_directory, file_name])
  end

  def get_file_disposition(file_name) do
    "filename=#{URI.encode(file_name)}"
  end
end
