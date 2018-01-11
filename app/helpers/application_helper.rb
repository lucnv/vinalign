module ApplicationHelper
  def index_on_pagination counter, page, per_page
    (page - 1) * per_page + counter + 1
  end

  def gender_options
    Settings.genders.map {|gender| [t(".#{gender}"), gender]}
  end

  def custom_simple_format text
    simple_format strip_tags text
  end

  def time_with_format time, format = :default
    l time, format: format
  end
end
