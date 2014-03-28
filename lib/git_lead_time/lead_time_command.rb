require 'time'
require_relative 'branch'
require_relative 'lead_time_format'

module GitLeadTime
  class LeadTimeCommand
    attr_reader :branch, :ref
    def initialize(ref="HEAD")
      @branch = Branch.new(ref)
    end

    def run
      branch.each_merge.map { |merge| format_merge(merge) }
    end

    def format_merge(merge)
      LeadTimeFormat.new(merge).to_s
    end
  end
end
