require 'spec_helper'

module GitLeadTime
  describe LeadTimeCommand do
    it "prints lead times for all merges" do
      output = StringIO.new
      merge1 = double :merge
      merge2 = double :merge
      formatter = instance_double "GitLeadTime::LeadTimeFormatter"
      repo = instance_double "GitLeadTime::Repo"

      allow(formatter).to receive(:format).with(merge1) { "merge 1 formatted" }
      allow(formatter).to receive(:format).with(merge2) { "merge 2 formatted" }
      allow(repo).to receive(:each_merge).and_yield(merge1).and_yield(merge2)

      command = LeadTimeCommand.new(output: output, formatter: formatter, repo: repo)
      command.run

      expect(output.string.split("\n")).to eq [
        "merge 1 formatted",
        "merge 2 formatted",
      ]
    end
  end
end
