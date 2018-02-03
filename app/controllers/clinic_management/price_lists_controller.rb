class ClinicManagement::PriceListsController < ClinicManagement::BaseController
  def index
    @patient_record = current_clinic.patient_records.find params[:patient_record_id]
    @price_lists = @patient_record.price_lists
  end
end
