require_relative 'git'

module GitLeadTime
  class Merge
    attr_reader *%i[
      merge_commit first_commit message end_date start_date calculator
    ]

    def initialize(first_sha:, merge_sha:, calculator: GitLeadTime.calculator)
      @calculator = calculator

      @merge_commit, @message, @end_date =
        Git.status(merge_sha, :abbreviated_hash, :subject, :date)
      @first_commit, @start_date =
        Git.status(first_sha, :abbreviated_hash, :date)

      @end_date = Time.parse(@end_date)
      @start_date = Time.parse(@start_date)
    end

    def lead_time
      calculator.lead_time(start_date: start_date, end_date: end_date)
    end
  end
end
