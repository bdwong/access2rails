module Access2rails::Commands
  class GenerateCommand < Command
    def initialize
      super
      puts "*** GenerateCommand initializer"
      @options = {
        :models => true,
        :migrations => true,
      }
    end

    def option_parser
      puts "*** GenerateCommand parser"
      OptionParser.new do |opts|
        opts.banner = [
          "Usage: access2rails generate [options] file_or_directory...",
          "Run 'access2rails help commands' for a list of commands.",
        ].join("\n")

        opts.on("-m", "--[no-]models", "Generate rails models") do |m|
          @options[:models] = m
        end
        opts.on("-g", "--[no-]migrations", "Generate rails migrations") do |m|
          @options[:migrations] = m
        end
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end
    end

    def execute
      puts "*** GenerateCommand executor"
      files = file_list_from_args("*.xsd")

      if files.count == 0
        puts "No files to process!"
        puts @opt_parser.help
        exit
      end

      files.each do |schema_filename|
        schema = Access2rails::Xsd::Schema.from_xml(File.read(schema_filename))
        model_generator = Access2rails::ModelGenerator.from_schema(schema)
        migration_generator = Access2rails::MigrationGenerator.from_schema(schema)

        if @options[:models]
          model_path = File.join('app/models', model_generator.filename)
          File.open(model_path, 'w+') do |f|
            f.puts(model_generator.build)
          end
        end

        if @options[:migrations]
          migration_path = File.join('db/migrate', migration_generator.filename)
          File.open(migration_path, 'w+') do |f|
            f.puts(migration_generator.build)
          end
        end
      end
    end

  end
end