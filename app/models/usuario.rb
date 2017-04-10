class Usuario < ApplicationRecord
  # senha segura
  has_secure_password
  # associações
  has_many :bems, foreign_key: :usuario_id , dependent: :destroy
  validates_presence_of :nome, :sexo, :endereco, :idade, :cidade, :papel, :email, :password_digest
end
