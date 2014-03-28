require 'time'
require_relative 'first_commit_finder'
require_relative 'merge'
require_relative 'lead_time_format'

module GitLeadTime
  class LeadTimeCommand
    attr_reader :repo, :formatter, :output
    def initialize(output: $stdout, formatter: LeadTimeFormat.new, repo:)
      @output = output
      @repo = repo
      @formatter = formatter
    end

    def run
      repo.each_merge("HEAD") do |merge|
        output.puts formatter.format(merge)
      end
    end

    def merges
      `git rev-list --merges --first-parent HEAD | head -10`.lines.map(&:chomp)
    end
  end
end
