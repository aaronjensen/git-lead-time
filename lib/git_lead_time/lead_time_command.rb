require 'time'
require_relative 'first_commit_finder'
require_relative 'merge'
require_relative 'lead_time_format'
require_relative 'merge_enumerator'

module GitLeadTime
  class LeadTimeCommand
    attr_reader :first_commit_finder, :ref
    def initialize(ref="HEAD")
      @ref = ref
      @first_commit_finder = FirstCommitFinder.new(ref)
    end

    def run
      MergeEnumerator.new(ref).map.map { |merge| format_merge(merge) }
    end

    def format_merge(merge)
      LeadTimeFormat.new(Merge.new(merge, first_commit_finder)).to_s
    end
  end
end
