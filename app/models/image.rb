class Image < ApplicationRecord
  belongs_to :album

  mount_uploader :source, ImageUploader

  before_destroy :clean_s3

  private
  def clean_s3
    source.remove!
    source.thumb.remove! 
  rescue Excon::Errors::Error => error
    puts error
    false
  end
end
