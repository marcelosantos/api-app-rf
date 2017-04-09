require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  # Create test usuario
  let(:usuario) { create(:usuario) }
  # Mock `Authorization` header
  let(:header) { { 'Authorization' => token_generator(usuario.id) } }
  # Invalid request subject
  subject(:invalid_request_obj) { described_class.new({}) }
  # Valid request subject
  subject(:request_obj) { described_class.new(header) }

  # Suíte de Testes AuthorizeApiRequest#call
  # This is our entry point into the service class
  describe '#call' do
    # retorna o objeto usuário quando for uma requisição válida
    context 'quando for uma requisição válida' do
      it 'retorna o objeto usuário' do
        result = request_obj.call
        expect(result[:usuario]).to eq(usuario)
      end
    end

    # returns error message when invalid request
    context 'quando for uma requisição inválida' do
      context 'quando não existe um token' do
        it 'lança uma exceção MissingToken' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::MissingToken, /Missing token/)
        end
      end

      context 'quando for um token inválido' do
        subject(:invalid_request_obj) do
          # custom helper method `token_generator`
          described_class.new('Authorization' => token_generator(5))
        end

        it 'lança uma exceção InvalidToken' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
        end
      end

      context 'quando o token expirar' do
        let(:header) { { 'Authorization' => expired_token_generator(usuario.id) } }
        subject(:request_obj) { described_class.new(header) }

        it 'lança uma exceção ExceptionHandler::ExpiredSignature' do
          expect { request_obj.call }
            .to raise_error(
              ExceptionHandler::ExpiredSignature,
              /Signature has expired/
            )
        end
      end
    end
  end
end
