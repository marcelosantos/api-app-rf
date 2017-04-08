class Usuario < ApplicationRecord
  validates_presence_of :nome, :sexo, :endereco, :idade, :cidade, :papel
end
