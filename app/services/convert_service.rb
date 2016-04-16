module ConvertService
  module_function

  def upload(file, extension, user)
    return if file.nil? || extension.nil?
    convert_file = ConvertedFile.new
    convert_file.file = file
    convert_file.extension = Extension.find_by_name(extension)
    convert_file.user = user if user
    convert_file.save
    convert(convert_file, extension)
    convert_file
  rescue
    false
  end

  def convert(file, format)
  end
end
