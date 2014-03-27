module GitLeadTime
  class Merge
    attr_reader *%i[merge_commit first_commit message end_date start_date]

    def initialize(sha, first_commit_finder)
      first_sha = first_commit_finder.first_commit("#{sha}^2")
      @merge_commit, @message, @end_date = status("%h\n%s\n%cd", sha)
      @first_commit, @start_date = status("%h\n%cd", first_sha)
    end

    def lead_time
      (Time.parse(end_date) - Time.parse(start_date)) / 60 / 60 / 24
    end

    private
    def status(format, ref)
      `git show -s --format='#{format}' #{ref}`.lines.map(&:strip)
    end
  end
end
