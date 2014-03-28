module GitLeadTime
  class Calculator
    def lead_time(start_date:, end_date:)
      (end_date - start_date) / 60 / 60 / 24
    end
  end
end
