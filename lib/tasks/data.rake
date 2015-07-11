namespace :data do
  desc "TODO"
  task parse: :environment do
    Library.parse_data
  end

end
