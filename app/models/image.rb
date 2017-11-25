class Image < ApplicationRecord
  belongs_to :album

  mount_uploader :source, ImageUploader
end
