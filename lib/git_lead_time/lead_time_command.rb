require 'time'
require_relative 'first_commit_finder'
require_relative 'merge'
require_relative 'lead_time_format'

module GitLeadTime
  class LeadTimeCommand
    attr_reader :first_commit_finder
    def initialize(ref="HEAD")
      @first_commit_finder = FirstCommitFinder.new(ref)
    end

    def run
      merges.map { |merge| format_merge(merge) }
    end

    def merges
      `git rev-list --merges --first-parent HEAD | head -10`.lines.map(&:chomp)
    end

    def format_merge(merge)
      LeadTimeFormat.new(Merge.new(merge, first_commit_finder)).to_s
    end
  end
end
