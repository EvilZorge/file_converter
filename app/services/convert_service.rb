module ConvertService
  module_function

  def convert(file_id, extension, upload_to)
    file = ConvertedFile.find(file_id)
    file.update(state: 'converted')
    ExternalStorageService.upload(file, upload_to) if upload_to
  end
end
