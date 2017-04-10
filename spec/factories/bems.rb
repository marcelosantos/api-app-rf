FactoryGirl.define do
  factory :bem do
    nome { Faker::Name.first_name }
    tipo { Faker::Lorem.word }
    valor { Faker::Number.decimal(4, 2) }
    usuario_id nil
  end
end
