module GitLeadTime
  class MergeEnumerator
    include Enumerable

    attr_reader :ref
    def initialize(ref = "HEAD")
      @ref = ref
    end

    def each
      `git rev-list --merges --first-parent HEAD | head -10`.each_line do |rev|
        yield rev.strip
      end
    end
  end
end
