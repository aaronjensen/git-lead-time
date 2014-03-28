require_relative 'git'

module GitLeadTime
  class Merge
    attr_reader *%i[merge_commit first_commit message end_date start_date]

    def initialize(first_sha:, merge_sha:)
      @merge_commit, @message, @end_date =
        Git.status(merge_sha, :abbreviated_hash, :subject, :date)
      @first_commit, @start_date =
        Git.status(first_sha, :abbreviated_hash, :date)

      @end_date = Time.parse(@end_date)
      @start_date = Time.parse(@start_date)
    end

    def lead_time
      (end_date - start_date) / 60 / 60 / 24
    end
  end
end
