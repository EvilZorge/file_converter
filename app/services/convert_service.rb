module ConvertService
  module_function

  def upload(file, format_to, user)
    return if file.nil? || format_to.nil?
    convert_file = ConvertedFile.new
    convert_file.file = file
    convert_file.user = user if user
    convert_file.save
    convert(convert_file, format_to)
    convert_file
  rescue
    false
  end

  def convert(file, format)
  end
end
