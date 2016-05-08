module ConvertService
  module_function

  def convert(file_id, upload_to, email)
    file = ConvertedFile.find(file_id)
    converted_file =
      case file.extension.format.name
      when 'images'
        ImageService.convert(file)
      when 'documents'
        DocumentService.convert(file)
      when 'videos', 'audios'
        MediaService.convert(file)
      end
    converted_file.update(state: 'converted')
    ConvertMailer.send_email(email, converted_file) if email
    ExternalStorageService.upload(converted_file, upload_to) if upload_to
  end
end
