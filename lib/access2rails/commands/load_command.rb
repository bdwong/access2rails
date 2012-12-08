module Access2rails::Commands
  class LoadCommand < Command
    def option_parser
      OptionParser.new do |opts|
        opts.banner = [
          "Usage: access2rails load [options] file_or_directory...",
          "Run 'access2rails help commands' for a list of commands.",
        ].join("\n")

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end
    end

    def execute
      files = file_list_from_args("*.xml")

      if files.count == 0
        puts "No files to process!"
        puts @opt_parser.help
        exit
      end
    end
  end
end