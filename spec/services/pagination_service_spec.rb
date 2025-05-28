require 'rails_helper'

RSpec.describe PaginationService do
  let!(:records)    { create_list(:proponent, 50) }
  let(:collection)  { Proponent.order(:id) }
  let(:params)      { { page: page, per_page: per_page } }
  subject(:service) { described_class.new(collection, params) }

  describe '#metadata' do
    let(:page) { 1 }
    let(:per_page) { 5 }

    it 'memoizes PaginationMetadata' do
      m1 = service.metadata
      m2 = service.metadata
      expect(m1).to be(m2)
      expect(m1.per_page).to eq(per_page)
      expect(m1.count).to eq(records.size)
    end
  end

  describe '#results' do
    let(:page) { 3 }
    let(:per_page) { 10 }

    it 'returns the correct subset of collection' do
      result_ids = service.results.pluck(:id)
      expected_ids = records.map(&:id).slice(20, 10)
      expect(result_ids).to eq(expected_ids)
    end
  end
end
