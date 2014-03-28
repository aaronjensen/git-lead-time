require 'spec_helper'
require 'git_lead_time/first_commit_finder'

module GitLeadTime
  describe FirstCommitFinder, :git do
    it "finds the first commit of a new branch" do
      # Make a nasty graph complete with back merge
      # *   ca4080f - (HEAD, master) Merge branch 'topic' (0 seconds ago) <Aaron Jensen>
      # |\
      # | * d6b8382 - (topic) Topic C (0 seconds ago) <Aaron Jensen>
      # | *   d8d405a - Merge branch 'master' into topic (0 seconds ago) <Aaron Jensen>
      # | |\
      # | |/
      # |/|
      # * | 70a1894 - Master B (0 seconds ago) <Aaron Jensen>
      # | * 627ed43 - Topic B (0 seconds ago) <Aaron Jensen>
      # | * dd3be46 - Topic A (0 seconds ago) <Aaron Jensen>
      # |/
      # * bfd3a2b - Master A (0 seconds ago) <Aaron Jensen>
      git_commit "Master A"

      git "checkout", "-b", "topic"
      git_commit "Topic A"
      first_commit = git_head
      git_commit "Topic B"

      git "checkout", "master"
      git_commit "Master B"

      git "checkout", "topic"
      git_merge "master"

      git_commit "Topic C"

      git "checkout", "master"
      git_merge "topic"
      git "branch", "-D", "topic"

      finder = FirstCommitFinder.new("master")
      expect(finder.first_commit("master^2")).to eq(first_commit)
    end
  end
end
