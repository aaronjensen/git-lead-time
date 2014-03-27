require 'tmpdir'
require 'chronic'

module Support
  module Git
    def git_commit(message = :default, date: :now)
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

      unless date == :now
        args += ["--date", date]
      end

      git :commit, "--allow-empty", *args, date: date
      #git "rev-parse", "HEAD"
    end

    def git_merge(branch, date: :now)
       git :merge, "--no-ff", "--no-commit", "topic", date: date
       git_commit :no_edit, date: date
    end

    def git_head(abbreviated)
      if abbreviated
        git("show", "-s", "--format=%h").chomp
      else
        git("rev-parse", "HEAD").chomp
      end
    end

    def git(*args, date: :now)
      if date != :now
        ENV["GIT_COMMITTER_DATE"] = date
      end

      output = `#{["git", *args.map(&:to_s)].shelljoin} 2>&1`
      raise unless $?.success?
      output
    rescue
      puts output
      raise
    ensure
      ENV["GIT_COMMITTER_DATE"] = nil
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
