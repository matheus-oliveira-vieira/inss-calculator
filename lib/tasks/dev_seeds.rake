# Open a terminal and run the command to populate DB: rails dev:seeds
namespace :dev do
  desc "Populate the database with dummy data using FactoryBot"
  task seeds: :environment do
    puts "Starting dummy data generation..."

    require "factory_bot_rails"
    include FactoryBot::Syntax::Methods

    create(:proponent, :admin)
    puts "Admin criado: admin@inss.com / admin123"

    10.times do
      proponent = create(:proponent)
      create(:address, proponent: proponent)
      create(:contact, proponent: proponent)
    end

    puts "Data generated successfully!"
  end
end
