module Access2rails
  module IndexHelper
    def self.included(obj)
      obj.send(:include, InstanceMethods)
      obj.extend ClassMethods
    end

    module ClassMethods
      def from_hash(attributes)
        obj = new
        attributes.each do |key, value|
          if obj.respond_to?("#{key}=")
            obj.send("#{key}=", value)
          else
            raise ArgumentError, "Assignment to unknown attribute #{key}."
          end
        end
        obj
      end
    end

    module InstanceMethods
      def clustered?
        @clustered == "yes"
      end

      def primary?
        @primary == "yes"
      end

      def unique?
        @unique == "yes"
      end

      # TODO: refactor into utility method.
      def rails_column_name(column_name)
        column_name.underscore.gsub(" ", "_").gsub("_0x0020_", "_")
      end

      def index_columns
        columns = index_key.chomp.split(' ').map do |name|
          ":#{rails_column_name(name)}"
        end
        if columns.count > 1
          "[#{columns.join ", "}]"
        else
          columns[0]
        end
      end

      # Return the definition of the index as in an ActiveRecord migration.
      def definition(table_name)

        if unique?
          "    add_index :#{table_name}, #{index_columns}, :unique => true"
        else
          "    add_index :#{table_name}, #{index_columns}"
        end
      end
    end

  end
end
