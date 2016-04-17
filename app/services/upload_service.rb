module UploadService
  module_function

  def upload(file, extension, user, uploaded_url)
    return if file.nil? || extension.nil?
    convert_file = save_file(file, extension, user, uploaded_url)
    ConvertJob.perform_later(convert_file, extension)
    convert_file
  rescue
    false
  end

  def save_file(file, extension, user, uploaded_url)
    convert_file = ConvertedFile.new
    convert_file.extension = Extension.find_by_name(extension)
    convert_file.user = user if user
    if uploaded_url
      convert_file.remote_file_url = uploaded_url
    else
      convert_file.file = file
    end
    convert_file.save
    convert_file
  end
end
