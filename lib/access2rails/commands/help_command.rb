module Access2rails::Commands
  class HelpCommand < Command
    def option_parser
      OptionParser.new do |opts|
        opts.banner = [
          "Usage: access2rails help [options] command",
          "Run 'access2rails help commands' for a list of commands.",
        ].join("\n")

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end
    end

    def execute
      topic = ARGV.shift
      case topic
      when 'commands'
        puts [
          "The commands are:",
          "  help - get help on specific topics",
          "  generate - generate rails migrations and models from xsd files",
          "  load - load data from xml export of tables",
        ].join("\n")
      when 'generate'
        puts 'help for generate command'
      when 'load'
        puts 'help for load command'
      when 'help'
        puts @opt_parser.help
      else
        puts @opt_parser.help
      end
    end
  end
end