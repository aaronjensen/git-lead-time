require_relative 'first_commit_finder'
require_relative 'merge'

module GitLeadTime
  class MergeInformation
    attr_reader :first_commit_finder

    def initialize(ref, first_commit_finder: FirstCommitFinder.new(ref))
      @first_commit_finder = first_commit_finder
    end

    def info_for(merge_sha)
      # TODO: deal w/ octopus merges
      first_sha = first_commit_finder.first_commit("#{merge_sha}^2")
      Merge.new(first_sha: first_sha, merge_sha: merge_sha)
    end
  end
end
