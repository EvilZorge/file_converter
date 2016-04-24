module ExtensionService
  module_function

  def check_extension(file, extension_to)
    return if file.nil?
    content_type = file.content_type
    extensions = prepare_extensions(content_type)
    return if extensions.empty?
    extensions.include?(extension_to)
  end

  def prepare_extensions(content_type)
    extension = extension_from_content_type(content_type)
    find_extensions(extension)
  end

  def extension_from_content_type(content_type)
    return if content_type.nil?
    preferred_extension = MIME::Types[content_type].first.preferred_extension
    Extension.find_by_name(preferred_extension)
  rescue
    nil
  end

  def find_extensions(extension)
    extension ? extension.converted_extensions.pluck(:name) : nil
  end
end
