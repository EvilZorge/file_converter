module UploadService
  module_function

  def upload(params, user)
    file = params[:file]
    extension = params[:extension_to]
    external = params[:external]
    upload_to = params[:upload_to]
    return if file.nil? || extension.nil?
    convert_file = save_file(file, extension, user, external, upload_to)
    convert_file
  rescue
    false
  end

  def save_file(file, extension, user, external, upload_to)
    convert_file = ConvertedFile.new
    convert_file.extension = Extension.find_by_name(extension)
    convert_file.user = user if user
    convert_file.file = file if external.nil?
    convert_file.save
    if external
      UploadJob.perform_later(convert_file.id, extension, external, upload_to)
    else
      ConvertJob.perform_later(convert_file.id, extension, upload_to)
    end
    convert_file
  end

  def upload_from_external_storage(file_id, extension, external, upload_to)
    params = JSON.parse external
    if params['from'] == 'google_drive'
      upload_from_google_drive(file_id, extension, params['url'], params['token'], upload_to)
    else
      upload_from_url(file_id, extension, params['url'], upload_to)
    end
  end

  def upload_from_url(file_id, extension, url, upload_to)
    file = ConvertedFile.find(file_id)
    file.remote_file_url = url
    file.save
    ConvertService.convert(file.id, extension, upload_to)
  end

  def upload_from_google_drive(file_id, extension, url, token, upload_to)
    file = ConvertedFile.find(file_id)
    headers = { "Authorization" => "Bearer #{token}" }
    file.file = FileUploader.new.download_from_url!(url, headers)
    file.save
    ConvertService.convert(file.id, extension, upload_to)
  end
end
