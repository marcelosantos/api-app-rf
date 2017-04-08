require 'rails_helper'

RSpec.describe Usuario, type: :model do
  # Association test
  # garantir que model Usuario tenha relacionamento 1:m com Bem model
  it { should have_many(:bems) } #.dependent(:destroy)
  # Validation tests
  # garantir que as colunas nome, sexo, endereco, idade, cidade, e papel existem antes de persistir
  it { should validate_presence_of(:nome) }
  it { should validate_presence_of(:sexo) }
  it { should validate_presence_of(:endereco) }
  it { should validate_presence_of(:idade) }
  it { should validate_presence_of(:cidade) }
  it { should validate_presence_of(:papel) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }
end
