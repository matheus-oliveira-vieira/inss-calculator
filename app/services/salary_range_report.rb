class SalaryRangeReport
  def self.generate
    ranges = {
      "Até R$ 1.518" => 0..1_518,
      "R$ 1.518,01 - R$ 2.793,88" => 1_518.01..2_793.88,
      "R$ 2.793.89 - R$ 4.190,83" => 2_793.89..4_190.83,
      "R$ 4.190,84 - R$ 8.157,41" => 4_190.84..8157.41,
      "Acima de R$ 8.157,41" => 8157.42..Float::INFINITY
    }

    ranges.map do |label, range|
      {
        label: label,
        count: Proponent.where(salary: range).count
      }
    end
  end
end
