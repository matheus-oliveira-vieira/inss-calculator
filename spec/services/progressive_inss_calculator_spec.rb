require 'rails_helper'

RSpec.describe ProgressiveInssCalculator do
  describe '#calculate' do
    context 'when salary is within the first bracket' do
      it 'calculates 7.5% for salary up to R$ 1.518,00' do
        calculator = described_class.new(1518.00)
        expect(calculator.calculate).to eq(1518.00 * 0.075)

        calculator = described_class.new(1000.00)
        expect(calculator.calculate).to eq(1000.00 * 0.075)
      end
    end

    context 'when salary is within the second bracket' do
      it 'calculates correctly for salary between R$ 1.518,01 and R$ 2.793,88' do
        calculator = described_class.new(1518.01)
        expected = (1518.00 * 0.075) + (0.01 * 0.09)
        expect(calculator.calculate).to eq(expected.round(2))

        calculator = described_class.new(2000.00)
        expected = (1518.00 * 0.075) + (2000.00 - 1518.01) * 0.09
        expect(calculator.calculate).to eq(expected.round(2))

        calculator = described_class.new(2793.88)
        expected = (1518.00 * 0.075) + (2793.88 - 1518.01) * 0.09
        expect(calculator.calculate).to eq(expected.round(2))
      end
    end

    context 'when salary is within the third bracket' do
      it 'calculates correctly for salary between R$ 2.793,89 and R$ 4.190,83' do
        calculator = described_class.new(2793.89)
        expected = (1518.00 * 0.075) + (2793.88 - 1518.01) * 0.09 + (0.01 * 0.12)
        expect(calculator.calculate).to eq(expected.round(2))

        calculator = described_class.new(3500.00)
        expected = (1518.00 * 0.075) + (2793.88 - 1518.01) * 0.09 + (3500.00 - 2793.89) * 0.12
        expect(calculator.calculate).to eq(expected.round(2))

        calculator = described_class.new(4190.83)
        expected = (1518.00 * 0.075) + (2793.88 - 1518.01) * 0.09 + (4190.83 - 2793.89) * 0.12
        expect(calculator.calculate).to eq(expected.round(2))
      end
    end

    context 'when salary is within the fourth bracket' do
      it 'calculates correctly for salary between R$ 4.190,84 and R$ 8.157,41' do
        calculator = described_class.new(4190.84)
        expected = (1518.00 * 0.075) + (2793.88 - 1518.01) * 0.09 + (4190.83 - 2793.89) * 0.12 + (0.01 * 0.14)
        expect(calculator.calculate).to eq(expected.round(2))

        calculator = described_class.new(5000.00)
        expected = (1518.00 * 0.075) + (2793.88 - 1518.01) * 0.09 + (4190.83 - 2793.89) * 0.12 + (5000.00 - 4190.84) * 0.14
        expect(calculator.calculate).to eq(expected.round(2))

        calculator = described_class.new(8157.41)
        expected = (1518.00 * 0.075) + (2793.88 - 1518.01) * 0.09 + (4190.83 - 2793.89) * 0.12 + (8157.41 - 4190.84) * 0.14
        expect(calculator.calculate).to eq(expected.round(2))
      end
    end

    context 'when salary is above the maximum bracket' do
      it 'calculates correctly for salary above R$ 8.157,41' do
        calculator = described_class.new(9000.00)
        expected = (1518.00 * 0.075) + (2793.88 - 1518.01) * 0.09 + (4190.83 - 2793.89) * 0.12 + (8157.41 - 4190.84) * 0.14
        expect(calculator.calculate).to eq(expected.round(2))

        calculator = described_class.new(10000.00)
        expect(calculator.calculate).to eq(expected.round(2))
      end
    end

    context 'with edge cases' do
      it 'returns zero for zero salary' do
        calculator = described_class.new(0.00)
        expect(calculator.calculate).to eq(0.00)
      end

      it 'returns zero for negative salary' do
        calculator = described_class.new(-1000.00)
        expect(calculator.calculate).to eq(0.00)
      end

      it 'handles decimal values correctly' do
        calculator = described_class.new(1234.56)
        expected = (1234.56 * 0.075)
        expect(calculator.calculate).to eq(expected.round(2))
      end
    end
  end

  describe 'brackets' do
    it 'has the correct bracket definitions' do
      expected_brackets = [
        { min: 0.00, max: 1518.00, rate: 0.075 },
        { min: 1518.01, max: 2793.88, rate: 0.09 },
        { min: 2793.89, max: 4190.83, rate: 0.12 },
        { min: 4190.84, max: 8157.41, rate: 0.14 }
      ].freeze

      expect(described_class::BRACKETS).to eq(expected_brackets)
      expect(described_class::BRACKETS).to be_frozen
    end
  end
end
