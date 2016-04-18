module ConvertService
  module_function

  def convert(file_id, extension)
    ConvertedFile.find(file_id).update(state: 'converted')
  end
end
