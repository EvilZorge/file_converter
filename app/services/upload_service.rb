module UploadService
  module_function

  def upload(file, extension, user, external)
    return if file.nil? || extension.nil?
    convert_file = save_file(file, extension, user, external)
    convert_file
  rescue
    false
  end

  def save_file(file, extension, user, external)
    convert_file = ConvertedFile.new
    convert_file.extension = Extension.find_by_name(extension)
    convert_file.user = user if user
    convert_file.file = file if external.nil?
    convert_file.save
    if external
      UploadJob.perform_later(convert_file.id, extension, external)
    else
      ConvertJob.perform_later(convert_file.id, extension)
    end
    convert_file
  end

  def upload_from_external_storage(file_id, extension, external)
    params = JSON.parse external
    if params['from'] == 'google_drive'
      upload_from_google_drive(file_id, extension, params['url'], params['token'])
    else
      upload_from_url(file_id, extension, params['url'])
    end
  end

  def upload_from_url(file_id, extension, url)
    file = ConvertedFile.find(file_id)
    file.remote_file_url = url
    file.save
    ConvertService.convert(file.id, extension)
  end

  def upload_from_google_drive(file_id, extension, url, token)
    file = ConvertedFile.find(file_id)
    headers = { "Authorization" => "Bearer #{token}" }
    file.file = FileUploader.new.download_from_url!(url, headers)
    file.save
    ConvertService.convert(file.id, extension)
  end
end
