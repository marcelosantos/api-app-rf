require 'rails_helper'

RSpec.describe Usuario, type: :model do
  # Association test
  it "garantir que model Usuario tenha relacionamento 1:m com Bem model" do
    should have_many(:bems) #.dependent(:destroy)
  end
  # Validation tests
  describe "garantir que as colunas nome, sexo, endereco, idade, cidade, e papel existem antes de persistir" do
    it { should validate_presence_of(:nome) }
    it { should validate_presence_of(:sexo) }
    it { should validate_presence_of(:endereco) }
    it { should validate_presence_of(:idade) }
    it { should validate_presence_of(:cidade) }
    it { should validate_presence_of(:papel) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
  end
end
