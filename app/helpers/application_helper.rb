module ApplicationHelper
  def gender_options
    Settings.genders.map {|gender| [t(".#{gender}"), gender]}
  end
end
