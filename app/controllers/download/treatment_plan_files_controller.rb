class Download::TreatmentPlanFilesController < ApplicationController
  def show
    treatment_plan_file = TreatmentPlanFile.find params[:id]
    file_name = File.basename treatment_plan_file.source.path
    data = open(treatment_plan_file.source.url)
    send_data data.read, filename: file_name, type: data.content_type, x_sendfile: true
  end
end
