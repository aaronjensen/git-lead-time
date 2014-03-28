require 'business_time'

require_relative 'git_lead_time/lead_time_command'
require_relative 'git_lead_time/calculator'

module GitLeadTime
  def self.run
    puts LeadTimeCommand.new.run
  end

  def self.calculator
    @calculator ||= Calculator.new
  end
end
