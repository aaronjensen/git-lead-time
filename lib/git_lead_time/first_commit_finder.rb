require 'set'

module GitLeadTime
  class FirstCommitFinder
    attr_reader :target_refs
    def initialize(merge_target)
      @target_refs = Set.new(first_parents(merge_target))
    end

    def first_commit(ref)
      first_commit = ref
      first_parents(ref).each do |parent|
        break if target_refs.include? parent
        first_commit = parent
      end

      first_commit
    end

    private
    def first_parents(ref)
      return to_enum(__method__, ref) unless block_given?

      `git rev-list --first-parent #{ref}`.each_line do |line|
        yield line.strip
      end
    end
  end
end
