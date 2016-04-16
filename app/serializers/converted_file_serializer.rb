class ConvertedFileSerializer < ActiveModel::Serializer
  attributes :download_url, :state, :format, :extension, :filename, :created_at

  def download_url
    object.file.url
  end

  def extension
    object.extension.name
  end

  def format
    object.extension.format.name
  end

  def filename
    object.file.uploaded_filename
  end
end
