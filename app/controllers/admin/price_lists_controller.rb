class Admin::PriceListsController < Admin::BaseController 
  before_action :patient_record

  def index
    price_lists
  end

  def new 
    @price_list = PriceList.new
  end

  def create
    @price_list = @patient_record.price_lists.build price_list_params
    if @price_list.save
      price_lists
      flash.now[:success] = t ".success"
    else
      flash.now[:failed] = t ".failed"
    end
  end

  private
  def patient_record
    @patient_record = PatientRecord.find params[:patient_record_id]
  end

  def price_list_params
    params.require(:price_list).permit PriceList::ATTRIBUTES
  end

  def price_lists
    @price_lists = @patient_record.price_lists
  end
end
