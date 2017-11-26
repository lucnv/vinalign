class Download::TreatmentPlanFilesController < ApplicationController 
  def show
    treatment_plan_file = TreatmentPlanFile.find params[:id] 
    file_name = File.basename treatment_plan_file.source.path
    send_file treatment_plan_file.source.path, file_name: file_name,
      type: "application/#{treatment_plan_file.source.file.extension}"
  end
end
