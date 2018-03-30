module ApplicationHelper
  def index_on_pagination counter, page, per_page
    (page - 1) * per_page + counter + 1
  end

  def gender_options
    Settings.genders.map {|gender| [t(".#{gender}"), gender]}
  end

  def clinic_options
    Clinic.has_no_doctor.pluck :name, :id
  end

  def article_category_options
    Article::categories.map {|key, value| [t(".#{key}"), value]}
  end

  def custom_simple_format text
    simple_format strip_tags text
  end

  def time_with_format time, format = :default
    l time, format: format if time.present?
  end

  def notification_content_format content
    simple_format content, {}, wrapper_tag: "span"
  end

  def article_content_format content
    sanitize content, tags: Loofah::HTML5::WhiteList::ALLOWED_ELEMENTS_WITH_LIBXML2 + ["iframe"],
      attributes: Loofah::HTML5::WhiteList::ALLOWED_ATTRIBUTES
  end
end
