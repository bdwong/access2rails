module Access2rails
  class MigrationGenerator
    attr_accessor :name, :timestamp, :filename

    def self.from_schema(schema)
      self.new(schema)
    end

    def initialize(schema)
      @schema = schema
      self.name = schema.normalized_name.camelize
      self.timestamp = Time.now.strftime("%Y%m%d%H%M%S")
    end

    def filename
      @filename ||= default_filename
    end

    def default_filename
      "#{timestamp}_create_#{table_name}.rb"
    end

    def table_name
      @schema.rails_name.underscore.pluralize
    end

    def build
      b = []
      b << "class Create#{@name} < ActiveRecord::Migration"
      b << "  def change"
      b << "    create_table :#{table_name} do |t|"

      @schema.columns.each do |c|
        b << c.definition
      end

      b << "    end"
      b << "" if @schema.indices.count > 0

      @schema.indices.each do |index|
        b << index.definition(table_name)
      end

      b << "  end"
      b << "end"

      b.join("\n")
    end

  end
end
