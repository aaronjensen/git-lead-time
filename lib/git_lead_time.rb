require_relative 'git_lead_time/lead_time_command'

module GitLeadTime
  def self.run
    puts LeadTimeCommand.new.run
  end

  def self.each_merge

  end
end
