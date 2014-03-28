module Support
  module Dates
    def date(str)
      Chronic.parse(date, now: Time.local(2014, 2, 1))
    end
  end
end

RSpec.configure do |config|
  config.include Support::Dates
end
