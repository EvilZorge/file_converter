module UploadService
  module_function

  def upload(file, extension, user, uploaded_url)
    return if file.nil? || extension.nil?
    convert_file = save_file(file, extension, user, uploaded_url)
    convert_file
  rescue
    false
  end

  def save_file(file, extension, user, uploaded_url)
    convert_file = ConvertedFile.new
    convert_file.extension = Extension.find_by_name(extension)
    convert_file.user = user if user
    convert_file.file = file if uploaded_url.nil?
    convert_file.save
    if uploaded_url
      UploadJob.perform_later(convert_file.id, extension, uploaded_url)
    else
      ConvertJob.perform_later(convert_file.id, extension)
    end
    convert_file
  end

  def upload_from_url(file_id, extension, url)
    file = ConvertedFile.find(file_id)
    file.remote_file_url = url
    file.save
    ConvertService.convert(file.id, extension)
  end
end
