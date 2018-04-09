class ImportPriceListsService
  attr_reader :patient_record, :file

  def initialize patient_record, file
    @patient_record = patient_record
    @file = file
  end

  def perform
    header = spreadsheet.row(1).map &:to_sym
    return if (header - PriceList::ATTRIBUTES).present?
    ActiveRecord::Base.transaction do
      (2..spreadsheet.last_row).each do |i|
        row_data = Hash[header.zip spreadsheet.row(i)]
        patient_record.price_lists.create! row_data
      end
    end
    true
  rescue
    false
  end

  private
  def spreadsheet
    @spreadsheet ||= case File.extname file.original_filename
    when ".csv"
      Roo::CSV.new file.path
    when ".xls"
      Roo::Excel.new file.path
    when ".xlsx"
      Roo::Excelx.new file.path
    end
  end
end
