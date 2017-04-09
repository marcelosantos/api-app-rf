require 'rails_helper'

RSpec.describe AuthenticateUsuario do
  # create test usuario
  let(:usuario) { create(:usuario) }
  # valid request subject
  subject(:valid_auth_obj) { described_class.new(usuario.email, usuario.password) }
  # invalid request subject
  subject(:invalid_auth_obj) { described_class.new('foo', 'bar') }

  # Test suite for AuthenticateUser#call
  describe '#call' do
    # return token when valid request
    context 'quando as credentials são válidas' do
      it 'retorna um token de autenticação' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end
    end

    # raise Authentication Error when invalid request
    context 'quando as credentials não são válidas' do
      it 'lança uma exceção de erro na autenticação' do
        expect { invalid_auth_obj.call }
          .to raise_error(
            ExceptionHandler::AuthenticationError,
            Message.invalid_credentials
          )
      end
    end
  end
end
