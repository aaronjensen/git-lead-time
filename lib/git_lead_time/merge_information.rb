require_relative 'first_commit_finder'
require_relative 'merge'

module GitLeadTime
  class MergeInformation
    attr_reader :first_commit_finder

    def initialize(ref)
      @first_commit_finder = FirstCommitFinder.new(ref)
    end

    def info_for(merge)
      Merge.new(merge, first_commit_finder)
    end
  end
end
