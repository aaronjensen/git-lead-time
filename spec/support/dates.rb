module Support
  module Dates
    def date(str)
      Chronic.parse(str, now: Time.local(2014, 2, 1))
    end

    def git_date(str)
      date(str).strftime("%a %b %-e %k:%M:%S %Y %z")
    end
  end
end

RSpec.configure do |config|
  config.include Support::Dates
end
