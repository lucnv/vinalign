class Article < ApplicationRecord
  include PgSearch

  PERSIST_ATTRIBUTES = [:title, :summary, :content, :category, :represent_image]

  scope :recent_created, ->{order created_at: :desc}
  scope :by_category, ->(category){where category: category}

  enum category: [:news, :case_gallery, :home]

  mount_uploader :represent_image, PreviewImageUploader

  validates :title, presence: true, length: {maximum: Settings.validations.article.title.max_length}
  validates :summary, presence: true, length: {maximum: Settings.validations.article.summary.max_length}
  validates :content, presence: true, length: {maximum: Settings.validations.article.content.max_length}
  validates :category, presence: true
  validates :represent_image,
    file_size: {less_than_or_equal_to: eval(Settings.validations.article.represent_image.max_size)}

  before_save :update_normalized_title

  pg_search_scope :search_by_title, against: {title: "A", normalized_title: "B"}

  private
  def update_normalized_title
    self.normalized_title = self.title.to_url.gsub "-", " "
  end
end
