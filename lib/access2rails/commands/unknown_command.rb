module Access2rails::Commands
  class UnknownCommand < Command
    def option_parser
      OptionParser.new do |opts|
        opts.banner = [
          "Usage: access2rails command [options] file_or_directory...",
          "Run 'access2rails help commands' for a list of commands.",
        ].join("\n")

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end
    end

    def execute
      puts @opt_parser.help
    end
  end
end