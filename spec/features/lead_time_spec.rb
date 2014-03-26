require 'spec_helper'

describe "git-lead-time", :git do
  it "shows the lead time for each merge" do
    git "lead-time"
    skip
  end
end
