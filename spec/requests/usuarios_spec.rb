require 'rails_helper'

RSpec.describe 'Usuários API', type: :request do
  let(:usuario) { build(:usuario) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:usuario, password_confirmation: usuario.password)
  end

  # Suíte de Teste GET /usuarios
  describe 'GET /usuarios' do
    context 'quando a requisição é válida' do
      before { get '/usuarios', params: valid_attributes.to_json, headers: headers }

      it 'retorna uma lista de usuários para o papel auditor' do
        expect(response).not_to be_nil
      end
    end
  end

  # Suíte de Teste POST /usuarios/adicionar
  #describe 'POST /usuarios/adicionar' do
    #context 'quando a requisição é válida para o perfil auditor' do
      #before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(usuario) }
      #before { post '/usuarios/adicionar', params: valid_attributes.to_json, headers: headers }

      #it 'permite criar um novo usuario' do
        #expect(response).to have_http_status(201)
      #end

      #it 'retorna uma mensagem de sucesso' do
        #expect(json['message']).to match(Message.account_created)
      #end

    #end
  #end

  # Suíte de Teste POST /signup
  describe 'POST /signup' do
    context 'quando a requisição é válida' do
      before { post '/signup', params: valid_attributes.to_json, headers: headers }

      it 'cria um novo usuario' do
        expect(response).to have_http_status(201)
      end

      it 'retorna uma mensagem de sucesso' do
        expect(json['message']).to match(Message.account_created)
      end

      it 'retorna um token de autenticação' do
        expect(json['auth_token']).not_to be_nil
      end
    end

    context 'quando a requisição não é válida' do
      before { post '/signup', params: {}, headers: headers }

      it 'não cria um novo usuario' do
        expect(response).to have_http_status(422)
      end

      it 'retorna uma mensagem de falha' do
        expect(json['message'])
          .to match(/Validation failed: Password can't be blank, Nome can't be blank, Sexo can't be blank, Endereco can't be blank, Idade can't be blank, Cidade can't be blank, Papel can't be blank, Email can't be blank, Password digest can't be blank/)
      end
    end
  end
end
