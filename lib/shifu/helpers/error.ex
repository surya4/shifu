defmodule Shifu.Helpers.Error do
  def map(:trashed_file) do
    %{
      message: "This file was trashed, you can restore the file from trash if needed.",
      code: 404
    }
  end

  def map(:unable_to_stream) do
    %{
      message: "Not able to stream the file currently. Please try again later.",
      code: 400
    }
  end

  def map(:server_error) do
    %{
      message: "Something went wrong.",
      code: 500
    }
  end

  def map(:api_not_found) do
    %{
      message: "API not found. Please check the API URL and request method type.",
      code: 404
    }
  end

  def map(:file_not_found, file_name) do
    %{
      message: "File not found for: #{file_name}",
      code: 404
    }
  end
end
