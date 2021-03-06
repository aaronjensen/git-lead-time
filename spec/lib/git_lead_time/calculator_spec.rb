require 'spec_helper'
require 'git_lead_time/calculator'

module GitLeadTime
  describe Calculator, "#lead_time" do
    subject(:calculator) { Calculator.new }

    it "should calculate the number of days between two times" do
      lead_time = calculator.lead_time(
        start_date: date("monday 9am"),
        end_date: date("tuesday 9am")
      )

      expect(lead_time).to eq 1.0
    end

    it "should not count weekends" do
      lead_time = calculator.lead_time(
        start_date: date("last friday 9am"),
        end_date: date("monday 9am")
      )

      expect(lead_time).to eq 1.0
    end

    it "should not count evenings" do
      lead_time = calculator.lead_time(
        start_date: date("monday 5pm"),
        end_date: date("tuesday 10am")
      )

      expect(lead_time).to eq 1.0 / 8.0
    end

    it "should deal with time zones" do
      start_date = Time.parse "2014-03-20 17:36:27 -0400"
      end_date = Time.parse "2014-03-20 16:18:37 -0700"

      lead_time = calculator.lead_time(start_date: start_date, end_date: end_date)

      expect(lead_time).to be > 0.2
    end
  end
end
