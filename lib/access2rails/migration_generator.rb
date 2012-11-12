module Access2rails
  class MigrationGenerator
    attr_accessor :name, :timestamp, :filename

    def self.from_schema(schema)
      self.new(schema)
    end

    def initialize(schema)
      @schema = schema
      @name = schema.name
      @timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    end

    def build
      "class CreateSchemaName"
    end

    def filename
      "#{timestamp}_create_#{name.underscore}.rb"
    end
  end
end