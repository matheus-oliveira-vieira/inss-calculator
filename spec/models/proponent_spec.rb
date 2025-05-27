require 'rails_helper'

RSpec.describe Proponent, type: :model do
  let(:valid_attributes) do
    {
      name: 'João Silva',
      cpf: "123.123.123-12",
      birth_date: Date.new(1990, 1, 1),
      salary: 3000.00,
      email: 'joao@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    }
  end

  describe 'associations' do
    it { should have_one(:address).dependent(:destroy) }
    it { should have_many(:contacts).dependent(:destroy) }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for(:address).allow_destroy(true) }
    it { should accept_nested_attributes_for(:contacts).allow_destroy(true) }
  end

  describe 'validations' do
    it 'is valid with valid attributes' do
      proponent = described_class.new(valid_attributes)
      expect(proponent).to be_valid
    end

    it 'is invalid without a cpf' do
      proponent = described_class.new(valid_attributes.merge(cpf: nil))
      expect(proponent).not_to be_valid
      expect(proponent.errors[:cpf]).to include("não pode ficar em branco")
    end

    context 'when salary is present' do
      it 'is invalid with negative salary' do
        proponent = described_class.new(valid_attributes.merge(salary: -100))
        expect(proponent).not_to be_valid
        expect(proponent.errors[:salary]).to include("deve ser maior ou igual a 0")
      end

      it 'is valid with zero salary' do
        proponent = described_class.new(valid_attributes.merge(salary: 0))
        expect(proponent).to be_valid
      end
    end
  end

  describe 'callbacks' do
    context 'when creating a non-admin proponent' do
      let(:proponent) { build(:proponent, admin: false, password: nil) }

      it 'sets a random password before validation' do
        expect(proponent.password).to be_nil
        proponent.valid?
        expect(proponent.password).not_to be_nil
        expect(proponent.password).to eq(proponent.password_confirmation)
        expect(proponent.password.length).to be >= 12
      end
    end

    context 'when creating an admin proponent' do
      let(:proponent) { build(:proponent, admin: true, password: nil) }

      it 'does not set a random password' do
        expect(proponent.password).to be_nil
        proponent.valid?
        expect(proponent.password).to be_nil
      end
    end
  end

  describe 'password requirements' do
    context 'for admin users' do
      it 'requires password' do
        proponent = described_class.new(valid_attributes.merge(admin: true, password: nil))
        expect(proponent).not_to be_valid
        expect(proponent.errors[:password]).to include("não pode ficar em branco")
      end
    end

    context 'for non-admin users' do
      it 'does not require password' do
        proponent = described_class.new(valid_attributes.merge(admin: false, password: nil))
        proponent.valid?
        expect(proponent).to be_valid
      end
    end
  end

  describe 'instance methods' do
    describe '#set_dummy_password_for_non_admin' do
      it 'sets password for non-admin' do
        proponent = described_class.new(valid_attributes.merge(admin: false, password: nil))
        expect { proponent.valid? }.to change { proponent.password }.from(nil).to(String)
      end

      it 'does not set password for admin' do
        proponent = described_class.new(valid_attributes.merge(admin: true, password: nil))
        expect { proponent.valid? }.not_to change { proponent.password }
      end
    end

    describe 'password requirements' do
      context 'for admin users' do
        it 'requires password' do
          proponent = described_class.new(valid_attributes.merge(admin: true, password: nil))
          expect(proponent).not_to be_valid
          expect(proponent.errors[:password]).to include("não pode ficar em branco")
        end
      end

      context 'for non-admin users' do
        it 'does not require password' do
          proponent = described_class.new(valid_attributes.merge(admin: false, password: nil))
          proponent.valid?
          expect(proponent).to be_valid
        end
      end
    end
  end
end
