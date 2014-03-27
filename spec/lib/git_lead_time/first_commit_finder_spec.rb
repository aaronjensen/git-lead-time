require 'spec_helper'
require 'git_lead_time/first_commit_finder'

module GitLeadTime
  describe FirstCommitFinder, :git do
    it "finds the first commit of a new branch" do
      git_commit "Initial commit"

      git "checkout", "-b", "topic"
      git_commit "Topic A"
      first_commit = git_head
      git_commit "Topic B"
      git_commit "Topic C"

      git "checkout", "master"
      git_merge "topic"
      git "branch", "-D", "topic"


      finder = FirstCommitFinder.new("master")
      expect(finder.first_commit("master^2")).to eq(first_commit)
    end
  end
end
