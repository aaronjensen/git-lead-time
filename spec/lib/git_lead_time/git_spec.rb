require 'spec_helper'
require 'git_lead_time/git'

module GitLeadTime
  describe Git, ".status", :git do
    before do
      commit = git_commit "My subject", on("monday")
      @hash = commit[/ ([0-9a-f]*)\]/, 1]
    end

    it "should return the subject" do
      subject = Git.status("HEAD", :subject).first
      expect(subject).to eq "My subject"
    end

    it "should return the date" do
      date = Git.status("HEAD", :date).first
      expect(date).to eq git_date("monday")
    end

    it "should return the abbreviated hash" do
      hash = Git.status("HEAD", :abbreviated_hash).first
      expect(hash).to eq @hash
    end

    it "should return everything at once" do
      hash, subject, date =
        Git.status("HEAD", :abbreviated_hash, :subject, :date)

      expect(hash).to eq @hash
      expect(subject).to eq "My subject"
      expect(date).to eq git_date("monday")
    end
  end
end
