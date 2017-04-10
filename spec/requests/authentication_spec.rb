require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  #Suíte de Teste Authentication
  describe 'POST /auth/login' do
    # create test user
    let!(:usuario) { create(:usuario) }
    # set headers for authorization
    let(:headers) { valid_headers.except('Authorization') }
    # set test valid and invalid credentials
    let(:valid_credentials) do
      {
        email: usuario.email,
        password: usuario.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    # set request.headers to our custon headers
    # before { allow(request).to receive(:headers).and_return(headers) }

    context 'quando a requisição é válida' do
      before { post '/auth/login', params: valid_credentials, headers: headers }

      it 'retorna um token de autenticação e o usuário logado' do
        expect(json['auth_token']).not_to be_nil
        expect(json['logado']).not_to be_nil
      end
    end

    context 'quando a requisição não é válida' do
      before { post '/auth/login', params: invalid_credentials, headers: headers }

      it 'retorna uma mensagem de erro' do
        expect(json['message']).to match(Message.invalid_credentials)
      end
    end
  end
end
