defmodule Portfolio.Cloudinary do
  @cloud_name System.get_env("CLOUDINARY_CLOUD_NAME")
  @api_key System.get_env("CLOUDINARY_API_KEY")
  @api_secret System.get_env("CLOUDINARY_API_SECRET")

  @upload_url "https://api.cloudinary.com/v1_1/#{@cloud_name}/image/upload"

  @spec upload_file(any()) :: {:error, <<_::64, _::_*8>> | HTTPoison.Error.t()} | {:ok, any()}
  def upload_file(filepath) do
    timestamp = :os.system_time(:second)
    signature = generate_signature(timestamp)

    body =
      {:multipart,
       [
         {:file, filepath},
         {"api_key", @api_key},
         {"timestamp", "#{timestamp}"},
         {"signature", signature}
       ]}

    headers = [{"Content-Type", "multipart/form-data"}]

    case HTTPoison.post(@upload_url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, "Cloudinary upload failed with status #{code}"}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp generate_signature(timestamp) do
    data = "timestamp=#{timestamp}#{@api_secret}"

    :crypto.hash(:sha, data)
    |> Base.encode16(case: :lower)
  end
end
