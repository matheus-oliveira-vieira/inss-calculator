require 'rails_helper'

RSpec.describe Api::V1::ReportsController, type: :request do
  describe 'GET /api/v1/reports/salary_ranges' do
    let(:report_data) { [ { range: '0-1000', count: 5 }, { range: '1001-2000', count: 3 } ] }

    before do
      allow(SalaryRangeReport).to receive(:generate).and_return(report_data)
    end

    context 'when requesting JSON format' do
      it 'returns status 200' do
        get '/api/v1/reports/salary_ranges', headers: { 'ACCEPT' => 'application/json' }
        expect(response).to have_http_status(:ok)
      end

      it 'returns the report data as JSON' do
        get '/api/v1/reports/salary_ranges', headers: { 'ACCEPT' => 'application/json' }
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json).to eq(report_data)
      end

      it 'renders JSON response' do
        get '/api/v1/reports/salary_ranges', headers: { 'ACCEPT' => 'application/json' }
        expect(response.content_type).to include('application/json')
      end
    end
  end
end
