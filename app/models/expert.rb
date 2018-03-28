class Expert < ApplicationRecord
  ATTRIBUTES = [:first_name, :last_name, :district_id, :address,
    :avatar, :title, :workplace, :facebook_url, :priority]
  PRIORITIES = Settings.experts.priorities

  belongs_to :district
  has_one :province, through: :district

  validates :first_name, presence: true, length: {maximum: Settings.validations.expert.first_name.max_length}
  validates :last_name, presence: true, length: {maximum: Settings.validations.expert.last_name.max_length}
  validates :district_id, presence: true
  validates :address, presence: true, length: {maximum: Settings.validations.expert.address.max_length}
  validates :title, presence: true, length: {maximum: Settings.validations.expert.title.max_length}
  validates :workplace, presence: true, length: {maximum: Settings.validations.expert.workplace.max_length}
  validates :priority, presence: true, inclusion: {in: PRIORITIES,
    message: I18n.t("activerecord.errors.messages.must_in_list", list: PRIORITIES)}

  scope :full_name_cont, ->(name) do
    where "LOWER(CONCAT(#{Expert.table_name}.last_name, #{Expert.table_name}.first_name)) \
      LIKE '%#{name.to_s.downcase}%'"
  end
  scope :priority_desc, ->{order priority: :desc}
  scope :full_name_asc, ->{order "CONCAT(last_name, first_name)"}

  mount_uploader :avatar, AvatarUploader

  delegate :id, :name, to: :province, prefix: true, allow_nil: true

  def full_name
    last_name + " " + first_name
  end

  class << self
    def ransackable_scopes auth_object = nil
      [:full_name_cont]
    end
  end
end
