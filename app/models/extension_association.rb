class ExtensionAssociation < ActiveRecord::Base
  belongs_to :extension
  belongs_to :converted_extension, class_name: "Extension"
end
