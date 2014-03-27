require 'time'
require_relative 'first_commit_finder'

module GitLeadTime
  class LeadTimeCommand
    attr_reader :first_commit_finder
    def initialize(ref="HEAD")
      @first_commit_finder = FirstCommitFinder.new(ref)
    end

    def run
      merges.map { |merge| format_merge(merge) }
    end

    def merges
      `git rev-list --merges --first-parent HEAD | head -10`.lines.map(&:chomp)
    end

    def format_merge(merge)
      Format.new(Merge.new(merge, first_commit_finder)).to_s
    end

    class Merge
      attr_reader *%i[merge_commit first_commit message end_date start_date]

      def initialize(sha, first_commit_finder)
        first_sha = first_commit_finder.first_commit("#{sha}^2")
        @merge_commit, @message, @end_date = status("%h\n%s\n%cd", sha)
        @first_commit, @start_date = status("%h\n%cd", first_sha)
      end

      def status(format, ref)
        `git show -s --format='#{format}' #{ref}`.lines.map(&:strip)
      end

      def lead_time
        (Time.parse(end_date) - start_date) / 60 / 60 / 24
      end

      def start_date
        Time.parse `git show -s --format=%cd #{first_commit}`
      end
    end

    class Format
      attr_reader :merge

      def initialize(merge)
        @merge = merge
      end

      def to_s
        "#{format_lead_time(merge.lead_time)} #{merge.first_commit}..#{merge.merge_commit} #{merge.message}"
      end

      def format_lead_time(lead_time)
        time = ("%5.1f" % lead_time)
        "#{time} day#{"s" unless time == "1.0"}"
      end
    end
  end
end
