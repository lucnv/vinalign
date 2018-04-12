class Admin::PriceListsController < Admin::BaseController
  before_action :patient_record, only: [:index, :new, :create, :import]
  before_action :price_list, only: [:edit, :update, :destroy]

  def index
    price_list_collection
    respond_to do |format|
      format.html
      format.xlsx
    end
  end

  def new
    @price_list = PriceList.new
  end

  def create
    @price_list = @patient_record.price_lists.build price_list_params
    if @price_list.save
      price_list_collection
      flash.now[:success] = t ".success"
      NotifyUpdatePriceListService.new(current_user.user_profile, @patient_record).perform
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
      NotifyUpdatePriceListService.new(current_user.user_profile, @price_list.patient_record).perform
    else
      flash.now[:failed] = t ".failed"
    end
  end

  def destroy
    if @price_list.destroy
      @patient_record = @price_list.patient_record
      price_list_collection
      flash[:success] = t ".success"
    else
      flash[:failed] = t ".failed"
    end
    redirect_to admin_patient_record_price_lists_path @patient_record
  end

  def import
    if ImportPriceListsService.new(@patient_record, params[:file]).perform
      flash[:success] = t ".success"
      NotifyUpdatePriceListService.new(current_user.user_profile, @patient_record).perform
    else
      flash[:failed] = t ".failed"
    end
    redirect_to admin_patient_record_price_lists_path @patient_record
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
