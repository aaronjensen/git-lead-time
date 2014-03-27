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
      attr_reader :sha, :hunk, :message, :end_date

      def initialize(sha)
        @sha = sha
        @hunk, @message, @end_date = status("%h\n%s\n%cd")
      end

      def status(format)
        `git show -s --format='#{format}' #{sha}`.lines.map(&:strip)
      end

      def lead_time
        (Time.parse(end_date) - start_date) / 60 / 60 / 24
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
        time = ("%5.1f" % lead_time)
        "#{time} day#{"s" unless time == "1.0"}"
      end
    end
  end
end
