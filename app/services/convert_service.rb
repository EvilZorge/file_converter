module ConvertService
  module_function

  def convert(file, user)
    return if file.nil?
    convert_file = ConvertedFile.new
    convert_file.file = file
    convert_file.user = user if user
    convert_file.save
    convert_file
  rescue
    false
  end
end
