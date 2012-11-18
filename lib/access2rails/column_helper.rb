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
      def money_type?
        @jet_type == "currency" or @sqlSType == "money"
      end

      def rails_type
        case @type
        when "xsd:int", "xsd:short"
          "integer"
        when "xsd:double"
          if money_type?
            "decimal"
          else
            "float"
          end

        when "xsd:string"
          "string"
        when "xsd:boolean"
          "boolean"
        when "xsd:datetime"
          "datetime"
        else
          raise ArgumentError, "Unknown column type '#{@type}'."
        end
      end

      def options
        opts = []
        opts << ":limit => #{@max_length}" if @max_length
        opts << ":precision => 15, :scale => 2" if money_type?
        opts.join(", ")
      end

      def rails_column_name
        @name.underscore.gsub(" ", "_").gsub("_0x0020_", "_")
      end

      def definition
        unless options.empty?
          "      t.#{rails_type} :#{rails_column_name}, #{options}"
        else
          "      t.#{rails_type} :#{rails_column_name}"
        end
      end
    end

  end
end