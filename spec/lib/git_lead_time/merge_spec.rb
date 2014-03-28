require 'spec_helper'
require 'git_lead_time/merge'

module GitLeadTime
  describe Merge do
    it "should get info from git" do
      allow(Git).to receive(:status).with("aa", :abbreviated_hash, :date) {
        [ "a", git_date("monday") ] }
      allow(Git).to receive(:status).with("bb", :abbreviated_hash, :subject, :date) {
        [ "b", "subject", git_date("tuesday") ] }
      merge = Merge.new(first_sha: "aa", merge_sha: "bb")

      expect(merge.message).to eq "subject"
      expect(merge.start_date).to eq date("monday")
      expect(merge.end_date).to eq date("tuesday")
      expect(merge.first_commit).to eq "a"
      expect(merge.merge_commit).to eq "b"
    end
  end
end
