class EmailFormatValidator < ActiveModel::EachValidator
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def validate_each record, attribute, value
    if value.present? && value !~ VALID_EMAIL_REGEX
      record.errors.add attribute, :invalid
    end
  end
end
