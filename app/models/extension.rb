class Extension < ActiveRecord::Base
  belongs_to :format

  has_many :extension_associations
  has_many :converted_extensions, through: :extension_associations
  has_many :inverse_extension_associations, class_name: "ExtensionAssociation", foreign_key: "converted_extension_id"
  has_many :inverse_extensions, through: :inverse_extension_associations, source: :extension
  has_many :converted_files
end
