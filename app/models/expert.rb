class Expert < ApplicationRecord
  include PgSearch

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
  scope :priority_sort, ->{order priority: :asc}
  scope :full_name_asc, ->{order "CONCAT(last_name, first_name)"}

  before_save :update_normalized_fields

  mount_uploader :avatar, AvatarUploader

  delegate :id, :name, to: :province, prefix: true, allow_nil: true

  pg_search_scope :search_by_full_name, against: {first_name: "A", last_name: "A", normalized_name: "B"}
  pg_search_scope :search_by_workplace, against: {workplace: "A", normalized_workplace: "B"}

  def full_name
    last_name + " " + first_name
  end

  class << self
    def ransackable_scopes auth_object = nil
      [:full_name_cont]
    end
  end

  private
  def update_normalized_fields
    self.normalized_name = (self.first_name + " " + self.last_name).to_url.gsub "-", " "
    self.normalized_workplace = self.workplace.to_url.gsub "-", " "
  end
end
