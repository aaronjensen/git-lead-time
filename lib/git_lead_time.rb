require_relative 'git_lead_time/lead_time_command'

module GitLeadTime
  def self.run
    puts LeadTimeCommand.new.run
  end
end
