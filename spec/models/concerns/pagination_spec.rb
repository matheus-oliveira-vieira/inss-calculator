require 'rails_helper'

RSpec.describe Pagination, type: :module do
  let!(:records) { create_list(:proponent, 25) }
  let(:scope)   { Proponent.order(:id) }
  let(:instance) do
    Class.new { include Pagination }.new
  end

  it 'returns metadata and results' do
    metadata, results = instance.paginate(collection: scope, params: { page: 3, per_page: 10 })

    expect(metadata.page).to eq(3)
    expect(metadata.per_page).to eq(10)
    expect(results.pluck(:id)).to eq(records.map(&:id).slice(20, 10))
  end
end
