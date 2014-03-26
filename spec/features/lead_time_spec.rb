require 'spec_helper'

describe "git-lead-time", :git do
  it "shows the lead time for each merge" do
    git_commit on("monday 9am")
    git :checkout, "-b", "topic"
    git_commit on("tuesday 9am")
    git :checkout, "master"
    git_merge "topic", on("wednesday 9am")

    git "log", "--graph"
    git "lead-time"
    skip
  end
end
