require 'rails_helper'

RSpec.describe Api::V1::ProponentsController, type: :request do
  let!(:proponent) { create(:proponent) }

  describe 'GET /api/v1/proponents' do
    it 'returns http success' do
      get api_v1_proponents_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /api/v1/proponents/new' do
    it 'initializes a new proponent with address and contact' do
      get new_api_v1_proponent_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /api/v1/proponents' do
    context 'with valid params' do
      let(:valid_params) do
        {
          proponent: attributes_for(:proponent).merge(
            address_attributes: attributes_for(:address),
            contacts_attributes: [ attributes_for(:contact) ]
          )
        }
      end

      it 'creates a new proponent and redirects' do
        expect {
          post api_v1_proponents_path, params: valid_params
        }.to change(Proponent, :count).by(1)
        expect(response).to redirect_to(api_v1_proponents_path)
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { proponent: { name: '' } } }

      it 'does not create and shows validation errors' do
        expect {
          post api_v1_proponents_path, params: invalid_params
        }.not_to change(Proponent, :count)

        expect(response.status).to eq(200)
      end
    end
  end

  describe 'GET /api/v1/proponents/:id/edit' do
    it 'renders the edit template' do
      get edit_api_v1_proponent_path(proponent)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /api/v1/proponents/:id' do
    it 'renders the show template (html)' do
      get api_v1_proponent_path(proponent)
      expect(response).to have_http_status(:success)
    end

    it 'returns json when requested' do
      get api_v1_proponent_path(proponent, format: :json)
      json = JSON.parse(response.body)
      expect(json['id']).to eq(proponent.id)
    end
  end

  describe 'PATCH /api/v1/proponents/:id' do
    context 'with valid params' do
      it 'updates the proponent and redirects' do
        patch api_v1_proponent_path(proponent), params: { proponent: { name: 'Novo Nome' } }
        expect(response).to redirect_to(api_v1_proponents_path)
        expect(proponent.reload.name).to eq('Novo Nome')
      end
    end
  end

  describe 'POST /api/v1/proponents/calculate_inss' do
    context 'with valid salary' do
      it 'returns calculated inss as json' do
        allow(ProgressiveInssCalculator).to receive(:new)
          .with(2000.0).and_return(double(calculate: 123.45))

        post calculate_inss_api_v1_proponents_path(format: :json),
            params: { salary: 2000 },
            headers: { 'ACCEPT' => 'application/json' }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json).to eq({ 'inss_discount' => 123.45, 'success' => true })
      end
    end

    context 'with invalid salary' do
      it 'returns error json' do
      post calculate_inss_api_v1_proponents_path(format: :json),
          params: { salary: 0 },
          headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json).to eq({ 'error' => 'Salário deve ser maior que zero', 'success' => false })
    end
    end
  end
end
