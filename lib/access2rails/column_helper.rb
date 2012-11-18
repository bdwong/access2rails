module Access2rails
  module ColumnHelper
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
      # copied from migration_generator
      def rails_type
        case @type
        when "xsd:int", "xsd:short"
          "integer"
        when "xsd:string"
          "string"
        end
      end

      def options
        if not @max_length.nil?
          ":limit => #{@max_length}"
        end
      end

      def definition
        if options
          "      t.#{rails_type} :#{@name.underscore}, #{options}"
        else
          "      t.#{rails_type} :#{@name.underscore}"
        end
      end
    end

  end
end