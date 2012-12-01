require 'fileutils'
require 'shellwords'

module ::CommandLineSteps

  def in_directory(dirname, &block)
    dirname ||= ""
    pwd = FileUtils.pwd
    begin
      FileUtils.chdir(File.expand_path(dirname))
      yield
    ensure
      FileUtils.chdir(pwd)
    end
  end

  def escaped_files
    @files.map do |name|
      Shellwords.escape(name)
    end.join(' ')
  end

  step "a( new?) command line" do
  end

  step "the user runs :cmd" do |cmd|
    puts "running '#{cmd}'"
    @output = `#{cmd}`
  end

  step "the output should include :string" do |string|
    @output.should include(string)
  end

  step "a new rails project at :path" do |path|
    @rails_path = path
    FileUtils.rm_rf(path)

    # Don't look too hard:
    # We only care about apps/models and db/migrate anyway.
    ['app/models', 'db/migrate'].each do |dir|
      FileUtils.mkdir_p(File.join(path, dir))
    end
  end

  step "example files at :path" do |path|
    @files = [File.expand_path(path)]
  end

  step "the user runs :cmd on examples" do |cmd|
    in_directory @rails_path do
      cmdline = "#{cmd} #{escaped_files}"
      puts "Running #{cmdline}"
      @output = `#{cmdline}`
    end
  end
end
