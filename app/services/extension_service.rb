module ExtensionService
  module_function

  def check_extension(file, extension_to)
    return if file.nil?
    extension = file.content_type
    extensions = prepare_extensions(extension)
    return if extensions.empty?
    extensions.include?(extension_to)
  end

  def prepare_extensions(extension)
    from_extension = format_extension(extension)
    find_extensions(from_extension)
  end

  def format_extension(extension)
    return if extension.nil?
    MIME::Types[extension].first.preferred_extension
  rescue
    nil
  end

  def find_extensions(from_extension)
    return if from_extension.nil?
    extension = Extension.find_by_name(from_extension)
    extension ? extension.converted_extensions.pluck(:name) : nil
  end
end
