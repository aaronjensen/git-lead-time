module GitLeadTime
  class LeadTimeFormat
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
