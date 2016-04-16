class UserSerializer < ActiveModel::Serializer
  attributes :email, :name, :lastname, :converted_files
  has_many :converted_files, serializer: ConvertedFileSerializer
end
