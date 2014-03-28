module GitLeadTime
  class Repo
    attr_reader :lookup_merge_info

    def initialize(lookup_merge_info: LookupMergeInfo)
      @lookup_merge_info = lookup_merge_info
    end

    def each_merge(ref)
      return to_enum(__method__, ref) unless block_given?
      MergeEnumerator.new(ref).each do |merge|
        yield lookup_merge_info.call(merge)
      end
    end
  end
end
