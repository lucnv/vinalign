class Article < ApplicationRecord
  include PgSearch

  PERSIST_ATTRIBUTES = [:title, :summary, :content, :category, :represent_image]

  scope :recent_created, ->{order created_at: :desc}
  scope :earlier_created, ->{order created_at: :asc}
  scope :by_category, ->(category){where category: category}
  scope :created_at_month, ->(time) do
    time = Time.parse time.to_s
    where created_at: time.beginning_of_month..time.end_of_month
  end

  validates :title, presence: true, length: {maximum: Settings.validations.article.title.max_length}
  validates :summary, presence: true, length: {maximum: Settings.validations.article.summary.max_length}
  validates :content, presence: true, length: {maximum: Settings.validations.article.content.max_length}
  validates :category, presence: true
  validates :represent_image,
    file_size: {less_than_or_equal_to: eval(Settings.validations.article.represent_image.max_size)}

  before_save :update_normalized_title

  enum category: [:news, :case_gallery, :home]

  mount_uploader :represent_image, PreviewImageUploader

  pg_search_scope :search_by_title, against: {title: "A", normalized_title: "B"}

  acts_as_url :title, url_attribute: :slug, sync_url: true, callback_method: :before_save

  def friendly_url_params
    {id: slug}
  end

  class << self
    def ransackable_scopes auth_object = nil
      [:created_at_month]
    end

    def friendly_find param
      find_by! slug: param
    end
  end

  private
  def update_normalized_title
    self.normalized_title = self.title.to_url.gsub "-", " "
  end
end
