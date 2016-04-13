module FormatService
  module_function

  def prepare_formats(format)
    from_extension = format_extension(format)
    find_extensions(from_extension)
  end

  def format_extension(format)
    return if format.nil?
    MIME::Types[format].first.preferred_extension
  rescue
    nil
  end

  def find_extensions(from_extension)
    return if from_extension.nil?
    extension = Extension.find_by_name(from_extension)
    extension ? extension.inverse_extension.pluck(:name) : nil
  end
end
