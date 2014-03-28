module GitLeadTime
  module Git
    def self.status(ref, *fields)
      format = {
        subject: "%s",
        abbreviated_hash: "%h",
        date: "%cd",
      }.values_at(*fields).join("\n")

      `git show -s --format='#{format}' #{ref}`.lines.map(&:strip)
    end
  end
end
