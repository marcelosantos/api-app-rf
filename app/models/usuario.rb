class Usuario < ApplicationRecord
  has_many :bems, dependent: :destroy
  validates_presence_of :nome, :sexo, :endereco, :idade, :cidade, :papel
end
