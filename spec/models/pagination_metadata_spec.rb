require 'rails_helper'

RSpec.describe PaginationMetadata do
  subject { described_class.new(page: page, per_page: per_page, count: count) }

  let(:page) { nil }
  let(:per_page) { nil }
  let(:count) { 42 }

  context 'defaults' do
    it 'uses default page and per_page' do
      expect(subject.page).to eq(1)
      expect(subject.per_page).to eq(PaginationMetadata::DEFAULT[:per_page])
    end

    it 'computes total_pages' do
      expect(subject.total_pages).to eq((count / subject.per_page.to_f).ceil)
    end
  end

  context 'navigation helpers' do
    let(:page) { 2 }
    let(:per_page) { 10 }
    let(:count) { 35 }

    it 'calculates offset' do
      expect(subject.offset).to eq(10)
    end

    it 'knows first and last page' do
      expect(subject.first_page?).to eq(false)
      expect(subject.last_page?).to eq(false)
      expect(subject.next_page?).to eq(true)
      expect(subject.previous_page?).to eq(true)
      expect(subject.next_page).to eq(3)
      expect(subject.previous_page).to eq(1)
    end
  end

  context 'at boundaries' do
    let(:page) { (count / per_page.to_f).ceil }
    let(:per_page) { 10 }
    let(:count) { 30 }

    it 'identifies last page' do
      expect(subject.last_page?).to be_truthy
      expect(subject.next_page).to be_nil
    end
  end
end
