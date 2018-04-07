class Image < ApplicationRecord
  belongs_to :album

  before_save :update_source_details
  before_destroy :clean_s3

  scope :order_name_asc, ->{order file_name: :asc}

  mount_uploader :source, ImageUploader

  private
  def clean_s3
    source.remove!
    source.thumb.remove!
  rescue Excon::Errors::Error => error
    puts error
    false
  end

  def update_source_details
    if source.present?
      self.assign_attributes file_name: source.file.filename, content_type: source.file.content_type,
        file_size: source.file.size
    end
  end
end
