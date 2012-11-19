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

    def table_name
      name.underscore.pluralize
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

    def filename
      "#{timestamp}_create_#{name.underscore}.rb"
    end

  end
end
