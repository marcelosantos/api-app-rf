FactoryGirl.define do
  factory :usuario do
    nome { Faker::Name.name }
    sexo { Faker::Lorem.word }
    endereco { Faker::Address.street_name }
    idade { Faker::Number.number(2) }
    cidade { Faker::Address.city }
    papel 'cidadao'
    email 'cidadao@test.gov.ce.br'
    password 'cidadao_acesso'
  end
end
