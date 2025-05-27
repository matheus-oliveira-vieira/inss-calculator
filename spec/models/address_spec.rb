require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:proponent) { create(:proponent) }
  let(:valid_attributes) do
    {
      street: 'Rua Exemplo',
      number: '123',
      neighborhood: 'Centro',
      city: 'São Paulo',
      state: 'SP',
      zip_code: '01001000',
      proponent: proponent
    }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      address = described_class.new(valid_attributes)
      expect(address).to be_valid
    end

    it 'is invalid without a zip_code' do
      address = described_class.new(valid_attributes.merge(zip_code: nil))
      expect(address).not_to be_valid
      expect(address.errors[:zip_code]).to include("não pode ficar em branco")
    end

    context 'when zip_code format is invalid' do
      invalid_zip_codes = [ '1234567', '123456789', 'ABCDEFGH' ]

      invalid_zip_codes.each do |zip_code|
        it "is invalid with zip_code #{zip_code}" do
          address = described_class.new(valid_attributes.merge(zip_code: zip_code))
          expect(address).not_to be_valid
          expect(address.errors[:zip_code]).to include('deve estar no formato 12345678 ou 12345-678')
        end
      end
    end

    context 'when zip_code format is valid' do
      valid_zip_codes = [ '12345678', '12345-678', '01234567' ]

      valid_zip_codes.each do |zip_code|
        it "is valid with zip_code #{zip_code}" do
          address = described_class.new(valid_attributes.merge(zip_code: zip_code))
          expect(address).to be_valid
        end
      end
    end
  end

  describe 'associations' do
    it 'belongs to a proponent' do
      association = described_class.reflect_on_association(:proponent)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'constants' do
    it 'has the correct STATES constant' do
      expected_states = [
        [ "Acre", "AC" ],
        [ "Alagoas", "AL" ],
        [ "Amapá", "AP" ],
        [ "Amazonas", "AM" ],
        [ "Bahia", "BA" ],
        [ "Ceará", "CE" ],
        [ "Distrito Federal", "DF" ],
        [ "Espírito Santo", "ES" ],
        [ "Goiás", "GO" ],
        [ "Maranhão", "MA" ],
        [ "Mato Grosso", "MT" ],
        [ "Mato Grosso do Sul", "MS" ],
        [ "Minas Gerais", "MG" ],
        [ "Pará", "PA" ],
        [ "Paraíba", "PB" ],
        [ "Paraná", "PR" ],
        [ "Pernambuco", "PE" ],
        [ "Piauí", "PI" ],
        [ "Rio de Janeiro", "RJ" ],
        [ "Rio Grande do Norte", "RN" ],
        [ "Rio Grande do Sul", "RS" ],
        [ "Rondônia", "RO" ],
        [ "Roraima", "RR" ],
        [ "Santa Catarina", "SC" ],
        [ "São Paulo", "SP" ],
        [ "Sergipe", "SE" ],
        [ "Tocantins", "TO" ]
      ]

      expect(described_class::STATES).to eq(expected_states)
      expect(described_class::STATES).to be_frozen
    end
  end
end
