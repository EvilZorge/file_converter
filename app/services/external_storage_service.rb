require 'dropbox_sdk'
module ExternalStorageService
  module_function

  def upload(file, upload_to)
    externals = JSON.parse upload_to
    externals.each { |e| send(e['name'].to_sym, file, e['token']) }
  end

  def dropbox(file, token)
    client = DropboxClient.new(token)
    file_data = open(file.file.path)
    client.put_file("/#{file.file.uploaded_filename}", file_data)
  end

  def google_drive(file, token)
    client = GoogleDrive.login_with_oauth(token)
    file_data = open(file.file.path)
    client.upload_from_file(file_data, file.file.uploaded_filename, convert: false)
  end
end
