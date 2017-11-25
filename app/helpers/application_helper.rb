module ApplicationHelper
  def gender_options
    Settings.genders.map {|gender| [t(".#{gender}"), gender]}
  end

  def custom_simple_format text
    simple_format strip_tags text
  end
end
