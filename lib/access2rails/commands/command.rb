require 'optparse'

module Access2rails::Commands
  class Command
    def initialize
      @options ||= {}
      @opt_parser = option_parser
    end

    # Get the list of files from command line arguments.
    def file_list_from_args(glob)
      files = []
      ARGV.each do |path|
        if File.directory?(path)
          files.concat(Dir.glob(File.join(path, glob)))
        elsif File.exists?(path)
          files << path
        else
          puts "File not found: #{path}"
          exit
        end
      end
      files
    end

    def parse
      begin
        @opt_parser.parse!
      rescue OptionParser::InvalidOption => e
        puts e.to_s
        puts @opt_parser.help
        exit
      end
    end
  end
end