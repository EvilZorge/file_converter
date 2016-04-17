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
end
