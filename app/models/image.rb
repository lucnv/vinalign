class Image < ApplicationRecord
  belongs_to :album

  mount_uploader :source, ImageUploader

  before_save :update_source_details
  before_destroy :clean_s3

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
