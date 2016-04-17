class FileUploadSerializer < ActiveModel::Serializer
  attributes :state

  def state
    object.state
  end
end
