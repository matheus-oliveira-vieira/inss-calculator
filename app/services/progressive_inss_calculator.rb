class ProgressiveInssCalculator
  BRACKETS = [
    { min: 0.00, max: 1518.00, rate: 0.075 },
    { min: 1518.01, max: 2793.88, rate: 0.09 },
    { min: 2793.89, max: 4190.83, rate: 0.12 },
    { min: 4190.84, max: 8157.41, rate: 0.14 }
  ].freeze

  def initialize(salary)
    @salary = salary
  end

  def calculate
    remaining_salary = @salary
    total_discount = 0.0

    BRACKETS.each do |bracket|
      break if remaining_salary <= bracket[:min]

      range_min = bracket[:min]
      range_max = [ bracket[:max], @salary ].min

      range_amount = range_max - range_min
      discount = range_amount * bracket[:rate]

      total_discount += discount
    end

    total_discount.round(2)
  end
end
