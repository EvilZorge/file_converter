class Format < ActiveRecord::Base
  has_many :extensions, dependent: :destroy
end
