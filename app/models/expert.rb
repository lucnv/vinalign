class Expert < ApplicationRecord
  belongs_to :district
  has_one :province, through: :district

  validates :first_name, presence: true, length: {maximum: Settings.validations.expert.first_name.max_length}
  validates :last_name, presence: true, length: {maximum: Settings.validations.expert.last_name.max_length}
  validates :district_id, presence: true
  validates :address, presence: true, length: {maximum: Settings.validations.expert.address.max_length}
  validates :title, presence: true, length: {maximum: Settings.validations.expert.title.max_length}
  validates :workplace, presence: true, length: {maximum: Settings.validations.expert.workplace.max_length}

  scope :full_name_cont, ->(name) do
    where "LOWER(CONCAT(#{Expert.table_name}.last_name, #{Expert.table_name}.first_name)) \
      LIKE '%#{name.to_s.downcase}%'"
  end

  mount_uploader :avatar, AvatarUploader

  class << self
    def ransackable_scopes auth_object = nil
      [:full_name_cont]
    end
  end
end
