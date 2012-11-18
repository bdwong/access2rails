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

      if (@schema.indices).count > 0
        b << ""

        @schema.indices.each do |index|
          b << formatted_index(index)
        end
      end

      b << "  end"
      b << "end"

      b.join("\n")
    end

    def filename
      "#{timestamp}_create_#{name.underscore}.rb"
    end

    def formatted_index(index)
      columns = index.index_key.chomp.split(' ').map do |name|
        ":#{name.underscore}"
      end
      if columns.count > 1
        index_columns = "[#{columns.join ", "}]"
      else
        index_columns = columns[0]
      end

      #TODO: make using the index_name optional. Currently we don't use it.
      if index.unique?
        "    add_index :#{table_name}, #{index_columns}, :unique => true"
      else
        "    add_index :#{table_name}, #{index_columns}"
      end
    end
  end
end
