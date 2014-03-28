require 'spec_helper'
require 'git_lead_time/repo'

module GitLeadTime
  describe Repo, "#each_merge" do
    it "should enumerage merges from the given ref" do
      merge_lookup = double :merge_lookup
      enumerator = instance_double "GitLeadTime::MergeEnumerator"
      stub_const("GitLeadTime::MergeEnumerator", double(new: enumerator))
      merge1 = double :merge1
      merge2 = double :merge2

      allow(enumerator).to receive(:each)
        .and_yield("merge1")
        .and_yield("merge2")
      allow(merge_lookup).to receive(:call).with("merge1") { merge1 }
      allow(merge_lookup).to receive(:call).with("merge2") { merge2 }

      repo = Repo.new(lookup_merge_info: merge_lookup)

      merges = repo.each_merge("HEAD").to_a
      expect(merges).to eq [merge1, merge2]
    end
  end
end
