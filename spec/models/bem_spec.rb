require 'rails_helper'

RSpec.describe Bem, type: :model do
  # Association test
  it "garantir que um registro do Bem model pertença a um registro do Usuario model" do
      should belong_to(:usuario)
  end
  # Validation tests
  describe "garantir que as colunas nome, tipo e valor existem antes de persistir" do
      it { should validate_presence_of(:nome) }
      it { should validate_presence_of(:tipo) }
      it { should validate_presence_of(:valor) }
  end
end
