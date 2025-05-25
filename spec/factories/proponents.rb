FactoryBot.define do
  factory :proponent do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8) }
    cpf { Faker::IdNumber.brazilian_citizen_number(formatted: true) }
    birth_date { Faker::Date.birthday(min_age: 18, max_age: 65) }
    salary { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    inss_discount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
  end

  trait :admin do
    email { "admin@inss.com" }
    password { "admin123" }
    admin { true }
  end
end
