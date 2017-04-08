require 'rails_helper'

RSpec.describe Usuario, type: :model do
  subject { described_class.new }

  describe 'Validações: ' do

    it "está válido e com todos os atributos" do
      subject.nome = 'Antônio'
      subject.sexo = 'f'
      subject.endereco = 'Rua dos Moradores, 10'
      subject.idade = 28
      subject.cidade = 'Fortaleza'
      subject.papel = 'cidadao'
      expect(subject).to be_valid
    end

    it "não é válido sem um nome" do
      subject.nome = nil
      expect(subject).to_not be_valid
    end

    it "não é válido sem um sexo" do
      subject.sexo = nil
      expect(subject).to_not be_valid
    end

    it "não é válido sem um endereço" do
      subject.endereco = nil
      expect(subject).to_not be_valid
    end

    it "não é válido sem uma idade" do
      subject.idade = nil
      expect(subject).to_not be_valid
    end

    it "não é válido sem uma cidade" do
      subject.cidade = nil
      expect(subject).to_not be_valid
    end

    it "não é válido sem um papel" do
      subject.papel = nil
      expect(subject).to_not be_valid
    end

  end

end
