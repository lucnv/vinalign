class Admin::PriceListsController < Admin::BaseController 
  before_action :patient_record, only: [:index, :new, :create]
  before_action :price_list, only: [:edit, :update]

  def index
    price_list_collection
  end

  def new 
    @price_list = PriceList.new
  end

  def create
    @price_list = @patient_record.price_lists.build price_list_params
    if @price_list.save
      price_list_collection
      flash.now[:success] = t ".success"
    else
      flash.now[:failed] = t ".failed"
    end
  end

  def edit
  end

  def update
    @price_list.assign_attributes price_list_params
    if @price_list.save 
      @patient_record = @price_list.patient_record
      price_list_collection
      flash.now[:success] = t ".success"
    else
      flash.now[:failed] = t ".failed"
    end
  end

  private
  def patient_record
    @patient_record = PatientRecord.find params[:patient_record_id]
  end

  def price_list 
    @price_list = PriceList.find params[:id]
  end

  def price_list_params
    params.require(:price_list).permit PriceList::ATTRIBUTES
  end

  def price_list_collection
    @price_lists = @patient_record.price_lists
  end
end
