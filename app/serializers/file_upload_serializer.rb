class FileUploadSerializer < ActiveModel::Serializer
  attributes :download_url, :state

  def download_url
    object.file.url
  end

  def state
    object.state
  end
end
