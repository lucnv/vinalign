namespace :db do
  task recreate: :environment do
    if Rails.env.development?
      list_task = %w[db:drop db:create db:migrate db:seed]
      list_task.each do |task|
        puts "\e[36mEXECUTE #{task} COMMAND\e[0m"
        Rake::Task[task].invoke
      end
    else
      puts "\e[31mdb:recreate task can be executed only in the development environment.\e[0m"
    end
  end
end
