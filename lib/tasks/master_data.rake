require "csv"

namespace :master_data do
  task import: :environment do
    models = %i[provinces districts]
    models.each do |model|
      import_master_data model
    end
  end
end

def import_master_data model
  klass = model.to_s.classify.safe_constantize
  puts "Import master data '#{model}'"
  ActiveRecord::Base.transaction do
    CSV.open(Rails.root.join("db", "master_data", "#{model}.csv"),
      {headers: true, header_converters: :downcase}).each do |row|
      params = row.to_hash.symbolize_keys
      instance = klass.find_or_initialize_by id: params[:id]
      instance.assign_attributes params
      instance.save!
    end
    sql_query = "SELECT setval('#{model}_id_seq', (SELECT max(id) FROM #{model}));"
    ActiveRecord::Base.connection.execute sql_query
  end
end
