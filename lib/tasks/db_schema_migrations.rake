namespace :db do
  desc "Prints all the migrations ran on the system"
  task :schema_migrations => :environment do
    puts ActiveRecord::Base.connection.select_values(
      'select version from schema_migrations order by version')
  end
end
