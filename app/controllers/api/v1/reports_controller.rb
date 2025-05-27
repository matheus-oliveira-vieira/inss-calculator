class Api::V1::ReportsController < ApplicationController
  def salary_ranges
    respond_to do |format|
      format.html { @salary_ranges = SalaryRangeReport.generate }
      format.json { render json: SalaryRangeReport.generate }
    end
  end
end
