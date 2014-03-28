require 'time'
require_relative 'merge'
require_relative 'lead_time_format'
require_relative 'merge_enumerator'
require_relative 'merge_information'

module GitLeadTime
  class LeadTimeCommand
    attr_reader :merge_information, :ref
    def initialize(ref="HEAD")
      @ref = ref
      @merge_information = MergeInformation.new(ref)
    end

    def run
      MergeEnumerator.new(ref).map.map { |merge| format_merge(merge) }
    end

    def format_merge(merge)
      LeadTimeFormat.new(merge_information.info_for(merge)).to_s
    end
  end
end
