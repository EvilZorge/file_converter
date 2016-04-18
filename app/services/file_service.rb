module FileService
  module_function

  def info_from_url(url)
    return if url.nil?
    response = Faraday.head url
    {
      size: response.headers['content-length'] || 0,
      type: response.headers['content-type'],
      name: File.basename(URI.parse(url).path)
    }
  end

  def check_state(id)
    file = ConvertedFile.find_by_id(id)
    file.state if file
  end
end
