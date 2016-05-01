module ExtensionService
  module_function

  def check_extension(file, extension_to)
    return if file.nil?
    content_type = file.content_type
    extensions = prepare_extensions(content_type)
    return if extensions.empty?
    extensions.any? { |extension| extension.has_value?(extension_to) }
  end

  def prepare_extensions(content_type)
    extension = extension_from_content_type(content_type)
    find_extensions(extension)
  end

  def extension_from_content_type(content_type)
    return if content_type.nil?
    preferred_extension = find_mime_type(content_type)
    Extension.find_by_name(preferred_extension)
  rescue
    nil
  end

  def find_mime_type(type)
    return 'mp3' if type == 'audio/mp3'
    MIME::Types[type].first.preferred_extension
  end

  def find_extensions(extension)
    extension ? extension.converted_extensions.joins(:format).map { |e| { extension: e.name, format: e.format.name } } : nil
  end
end
