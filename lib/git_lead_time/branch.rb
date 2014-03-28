require_relative 'merge_enumerator'
require_relative 'merge_information'

module GitLeadTime
  class Branch
    attr_reader :ref, :merge_information

    def initialize(ref)
      @ref = ref
      @merge_information = MergeInformation.new(ref)
    end

    def each_merge
      return to_enum(__method__) unless block_given?

      MergeEnumerator.new(ref).each do |merge|
        yield merge_information.info_for(merge)
      end
    end
  end
end
