require 'spec_helper'

describe "git lead-time", :git do
  it "shows the lead time for each merge" do
    git_commit "Initial commit", on("monday 9am")
    git :checkout, "-b", "topic"
    git_commit "Topic commit A", on("tuesday 9am")
    first_commit = git_head(:abbreviated)
    git_commit "Topic commit B", on("wednesday 9am")
    git :checkout, "master"
    merge_commit = git_merge "topic", on("thursday 9am")
    # Example: [master 160a500] Merge branch 'topic'
    sha, message = merge_commit.chomp.match(/^\[\S+ ([^\]]+)\] (.*)$/)[1,2]

    git "log", "--graph"
    output = git "lead-time"
    expect(output.lines.map(&:chomp)).to eq [
      "  2.0 days #{first_commit}..#{sha} #{message}"
    ]
  end
end
