class Article < ApplicationRecord
  scope :recent_created, ->{order created_at: :desc}

  enum category: [:news, :case_gallery]
end
