crumb :admin_root do
  link I18n.t("breadcrumbs.home"), admin_root_path
end

crumb :admin_clinics do
  link I18n.t("breadcrumbs.clinics"), admin_clinics_path
  parent :admin_root
end

crumb :clinic_mngt_root do
  link I18n.t("breadcrumbs.home"), clinic_management_root_path
end

crumb :clinic_mngt_patient_records do
  link I18n.t("breadcrumbs.patient_records"), clinic_management_patient_records_path
  parent :clinic_mngt_root
end

crumb :clinic_mngt_patient_record do |patient_record|
  link patient_record.full_name, clinic_management_patient_record_path(patient_record)
  parent :clinic_mngt_patient_records
end

crumb :clinic_mngt_new_patient_record do
  link I18n.t("breadcrumbs.new"), new_clinic_management_patient_record_path
  parent :clinic_mngt_patient_records
end

crumb :clinic_mngt_edit_patient_record do |patient_record|
  link I18n.t("breadcrumbs.edit"), edit_clinic_management_patient_record_path(patient_record)
  parent :clinic_mngt_patient_record, patient_record
end

crumb :clinic_mngt_patient_record_treatment_phases do |patient_record|
  link I18n.t("breadcrumbs.treatment_phases"),
    clinic_management_patient_record_treatment_phases_path(patient_record_id: patient_record.id)
  parent :clinic_mngt_patient_record, patient_record
end

crumb :clinic_mngt_patient_record_treatment_phase do |treatment_phase|
  link treatment_phase.name, clinic_management_treatment_phase_path(treatment_phase)
  parent :clinic_mngt_patient_record_treatment_phases, treatment_phase.patient_record
end

crumb :clinic_mngt_patient_record_price_lists do |patient_record|
  link I18n.t("breadcrumbs.price_lists"),
    clinic_management_patient_record_price_lists_path(patient_record_id: patient_record.id)
  parent :clinic_mngt_patient_record, patient_record
end
# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
