class Bem < ApplicationRecord
  validates_presence_of :nome, :tipo, :valor
  belongs_to :usuario
end
