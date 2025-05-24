Faker::Config.locale = 'pt-BR'

FactoryBot.define do
  factory :contact do
    proponent
    contact_type { 1 }
    value { Faker::PhoneNumber.phone_number }
  end
end
