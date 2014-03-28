require 'spec_helper'
require 'git_lead_time/merge_enumerator'

module GitLeadTime
  describe MergeEnumerator, :git do
    it "enumerates merges" do
      git_commit "Initial commit"
      merges = 3.times.map do
        git :checkout, "-b", "topic"
        git_commit "Topic commit"
        git :checkout, "master"
        git_merge "topic"
        git :branch, "-D", "topic"
        git_head
      end

      enum = MergeEnumerator.new("master")

      expect(enum.to_a).to eq merges.reverse
    end
  end
end
