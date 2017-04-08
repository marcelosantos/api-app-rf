require 'rails_helper'

RSpec.describe 'Bems API', type: :request do
  # inicializa dados de teste
  let!(:usuario) { create(:usuario) }
  let!(:bems) { create_list(:bem, 20, usuario_id: usuario.id) }
  let(:bem_id) { bems.first.id }
  let(:usuario_id) { usuario.id }
  let(:id) { bems.first.id }

  # Suíte de Testes GET /usuarios/:usuario_id/bems
  describe 'GET /usuarios/:usuario_id/bems' do
    before { get "/usuarios/#{usuario_id}/bems" }

    context 'quando o usuário existe' do
      it 'retorna código de status 200' do
        expect(response).to have_http_status(200)
      end

      it 'retorna todos os bems do usuário' do
        expect(json.size).to eq(20)
      end
    end

    context 'quando o usuário não existe' do
      let(:usuario_id) { 0 }

      it 'retorna código de status 404' do
        expect(response).to have_http_status(404)
      end

      it 'retorna uma mensagem de não encontrado' do
        expect(response.body).to match(/Couldn't find Usuario/)
      end
    end
  end

  # Suíte de Testes GET /usuarios/:usuario_id/bems/:id
  describe 'GET /usuarios/:usuario_id/bems/:id' do
    before { get "/usuarios/#{usuario_id}/bems/#{id}" }

    context 'quando o bem existe' do
      it 'retorna o código de status 200' do
        expect(response).to have_http_status(200)
      end

      it 'retorna o bem' do
        expect(json['id']).to eq(id)
      end
    end

    context 'quando o bem não existe' do
      let(:id) { 0 }

      it 'retorna o código de status 404' do
        expect(response).to have_http_status(404)
      end

      it 'retorna uma mensagem de não encontrado' do
        expect(response.body).to match(/Couldn't find Bem/)
      end
    end
  end

  # Suíte de Testes POST /usuarios/:usuario_id/bems
  describe 'POST /usuarios/:usuario_id/bems' do
    let(:valid_attributes) { { nome: 'Casa de Campo', tipo: 1, valor: 255788.22 } }

    context 'quando os atributos são válidos' do
      before { post "/usuarios/#{usuario_id}/bems", params: valid_attributes }

      it 'retorna o código de status 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'quando os atributos não são válidos' do
      before { post "/usuarios/#{usuario_id}/bems", params: {} }

      it 'retorna o código de status 422' do
        expect(response).to have_http_status(422)
      end

      it 'retorna uma mensagem de falha' do
        expect(response.body).to match(/Validation failed: Nome can't be blank/)
      end
    end
  end

  # Suíte de Testes PUT /usuarios/:usuario_id/bems/:id
  describe 'PUT /usuarios/:usuario_id/bems/:id' do
    let(:valid_attributes) { { nome: 'Pickup Ford', tipo: 2, valor: 98700.22 } }

    before { put "/usuarios/#{usuario_id}/bems/#{id}", params: valid_attributes }

    context 'quando um bem existe' do
      it 'retorna o código de status 204' do
        expect(response).to have_http_status(204)
      end

      it 'atualiza os dados do bem' do
        updated_bem = Bem.find(id)
        expect(updated_bem.nome).to match(/Pickup Ford/)
      end
    end

    context 'quando um bem existe' do
      let(:id) { 0 }

      it 'retorna o código de status 404' do
        expect(response).to have_http_status(404)
      end

      it 'retorna uma mensagem de não encontrado' do
        expect(response.body).to match(/Couldn't find Bem/)
      end
    end
  end

  # Suíte de Testes DELETE /usuarios/:id
  describe 'DELETE /usuarios/:id' do
    before { delete "/usuarios/#{usuario_id}/bems/#{id}" }

    it 'retorna o código de status 204' do
      expect(response).to have_http_status(204)
    end
  end

end
