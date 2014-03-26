require 'tmpdir'
require 'chronic'

module Support
  module Git
    def git_commit(message = :default, date:)
      @commit_counter ||= 0
      @commit_counter += 1
      args = []
      case message
      when :default
        args += ["-m", "Commit ##{@commit_counter}"]
      when :no_edit
        args += ["--no-edit"]
      else
        args += ["-m", message]
      end

      git :commit, "--allow-empty", "--date", date, "-m", message, date: date
    end

    def git_merge(branch, date:)
       git :merge, "--no-ff", "--no-commit", "topic", date: date
       git_commit :no_edit, date: date
    end

    def git(*args, date: :now)
      env = {}
      if date != :now
        env["GIT_COMMITTER_DATE"] = date
      end
      p date
      raise unless system(env, "git", *args.map(&:to_s))
    end

    def on(date)
      { date: Chronic.parse(date, now: Time.local(2014, 2, 1)).strftime("%a, %b %d %k:%M %Y %z") }
    end
  end
end

RSpec.configure do |config|
  config.around :each, :git do |example|
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        git :init
        example.run
      end
    end
  end

  config.include Support::Git, :git
end
