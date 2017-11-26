class MessagesController < ApplicationController 
  before_action :treatment_phase

  def create
    @message = @treatment_phase.messages.create message_params.merge user: current_user
  end

  private
  def treatment_phase
    @treatment_phase = TreatmentPhase.find params[:treatment_phase_id]
  end

  def message_params
    params.require(:message).permit Message::ATTRIBUTES
  end
end
