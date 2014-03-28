require 'time'
require_relative 'branch'
require_relative 'lead_time_format'

module GitLeadTime
  class LeadTimeCommand
    attr_reader :branch, :output
    def initialize(ref="HEAD", output: $stdout)
      @branch = Branch.new(ref)
      @output = output
    end

    def run
      branch.each_merge do |merge|
        output.puts format_merge(merge)
      end
    rescue Errno::EPIPE
      # Our buffer got closed by `head` or the like.
    end

    def format_merge(merge)
      LeadTimeFormat.new(merge).to_s
    end
  end
end
