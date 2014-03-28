module GitLeadTime
  class Calculator
    def lead_time(start_date:, end_date:)
      start_date.business_time_until(end_date) / 60 / 60 / 8
    end
  end
end
