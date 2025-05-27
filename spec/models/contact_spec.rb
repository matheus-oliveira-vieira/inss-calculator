require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:proponent) { create(:proponent) }
  let(:valid_attributes) do
    {
      contact_type: 'mobile',
      value: '(11) 98765-4321',
      proponent: proponent
    }
  end

  describe 'associations' do
    it { should belong_to(:proponent) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      contact = described_class.new(valid_attributes)
      expect(contact).to be_valid
    end

    it 'is invalid without a value' do
      contact = described_class.new(valid_attributes.merge(value: nil))
      expect(contact).not_to be_valid
      expect(contact.errors[:value]).to include("não pode ficar em branco")
    end

    context 'with different contact types' do
      it 'validates home_phone format' do
        contact = described_class.new(valid_attributes.merge(
          contact_type: 'home_phone',
          value: '(11) 1234-5678'
        ))
        expect(contact).to be_valid
      end

      it 'validates mobile format' do
        contact = described_class.new(valid_attributes.merge(
          contact_type: 'mobile',
          value: '(11) 98765-4321'
        ))
        expect(contact).to be_valid
      end

      it 'validates whatsapp format' do
        contact = described_class.new(valid_attributes.merge(
          contact_type: 'whatsapp',
          value: '(11) 98765-4321'
        ))
        expect(contact).to be_valid
      end
    end
  end

  describe 'enums' do
    it 'defines the expected contact types' do
      should define_enum_for(:contact_type)
        .with_values(
          home_phone: 1,
          mobile: 2,
          whatsapp: 3
        )
        .backed_by_column_of_type(:integer)
    end

    context 'with enum values' do
      it 'accepts valid contact types' do
        Contact.contact_types.each_key do |type|
          contact = described_class.new(valid_attributes.merge(contact_type: type))
          expect(contact).to be_valid
        end
      end

      it 'rejects invalid contact types' do
        expect {
          described_class.new(valid_attributes.merge(contact_type: :invalid_type))
        }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'scopes' do
    let!(:home_phone_contact) { create(:contact, contact_type: :home_phone) }
    let!(:mobile_contact) { create(:contact, contact_type: :mobile) }
    let!(:whatsapp_contact) { create(:contact, contact_type: :whatsapp) }

    it 'has scope for home phones' do
      expect(Contact.home_phone).to eq([ home_phone_contact ])
    end

    it 'has scope for mobiles' do
      expect(Contact.mobile).to eq([ mobile_contact ])
    end

    it 'has scope for whatsapps' do
      expect(Contact.whatsapp).to eq([ whatsapp_contact ])
    end
  end
end
