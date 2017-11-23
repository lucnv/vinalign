class Clinic::PriceListsController < Clinic::BaseController
  def index
    @patient_record = clinic.patient_records.find params[:patient_record_id]
    @price_lists = @patient_record.price_lists
  end
end
