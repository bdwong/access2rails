module Access2rails
	class ModelGenerator
    attr_accessor :filename

    def initialize(schema)
      @schema = schema
      @filename = default_filename
    end

    def self.from_schema(schema)
      self.new(schema)
    end

    def default_filename
      "#{@schema.rails_name}.rb"
    end

    def build
      b = []
      b << "class #{@schema.name} < ActiveRecord::Base"

      b << "  attr_accessor #{@schema.columns.map{|c| ":#{c.name.underscore}"}.join(', ')}"
      b << ""

      # Validations
      @schema.columns.each do |c|
        b << column_validations(c)
      end

      # xml accessors
      b << ""
      b << "  include ROXML"
      b << ""
      @schema.columns.each do |c|
        b << xml_accessor(c)
      end

      b << "end"
      b.join("\n")
    end

    def rails_column_name(col)
      col.name.underscore
    end

    def column_validations(col)
      validations = []
      prefix = "  validates :#{rails_column_name(col)},"

      if col.minoccurs.to_i > 0
        validations << "#{prefix} :presence => true"
      end

      if ["xsd:short", "xsd:int"].include?(col.type)
        validations << "#{prefix} :numericality => { :only_integer => true }"
      end

      if col.max_length
        validations << "#{prefix} :length => { :maximum => #{col.max_length} }"
      end

      validations.join("\n")
    end

    def xml_accessor(col)
      "  xml_accessor :#{rails_column_name(col)}"
    end
	end
end