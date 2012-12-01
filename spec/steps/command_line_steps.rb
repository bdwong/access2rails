module ::CommandLineSteps
  step "a( new?) command line" do
  end

  step "the user runs :cmd" do |cmd|
    puts "running '#{cmd}'"
    @output = `#{cmd}`
  end

  step "the output should include :string" do |string|
    @output.should include(string)
  end
end
