require 'tmpdir'

module Support
  module Git
    def git(*args, date: :now)
      env = {}
      if date != :now
        env["GIT_COMMITTER_DATE"] = date
      end
      raise unless system(env, "git", *args.map(&:to_s))
    end
  end
end

RSpec.configure do |config|
  config.around :each, :git do |example|
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        git "init"
        example.run
      end
    end
  end

  config.include Support::Git, :git
end
