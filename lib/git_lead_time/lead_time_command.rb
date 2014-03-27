require 'time'

module GitLeadTime
  class LeadTimeCommand
    def run
      merges.map { |merge| format_merge(merge) }
    end

    def merges
      `git rev-list --merges --first-parent HEAD | head -10`.lines.map(&:chomp)
    end

    def format_merge(merge)
      Format.new(Merge.new(merge)).to_s
    end

    class Merge
      attr_reader :sha

      def initialize(sha)
        @sha = sha
      end

      def hunk
        `git show -s --format='%h' #{sha}`.strip
      end

      def message
        `git show -s --format='%s' #{sha}`.strip
      end

      def lead_time
        (end_date - start_date) / 60 / 60 / 24
      end

      def end_date
        Time.parse `git show -s --format=%cd #{sha}`
      end

      def start_date
        # TODO: this is wrong
        Time.parse `git show -s --format=%cd #{sha}^2`
      end
    end

    class Format
      attr_reader :merge

      def initialize(merge)
        @merge = merge
      end

      def to_s
        "#{format_lead_time(merge.lead_time)} #{merge.hunk} #{merge.message}"
      end

      def format_lead_time(lead_time)
        time = "%.1g" % lead_time
        "#{time} day#{"s" unless time == "1"}"
      end
    end
  end
end
