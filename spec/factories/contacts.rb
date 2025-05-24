FactoryBot.define do
  factory :contact do
    proponent
    contact_type { 4 }
    value { Faker::Internet.email }
  end
end
