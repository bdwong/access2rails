module Access2rails
	class ModelGenerator
    attr_accessor :filename, :model_name

    def initialize(schema)
      @schema = schema
      self.filename = default_filename
      self.model_name = default_model_name
    end

    def self.from_schema(schema)
      self.new(schema)
    end

    def default_filename
      "#{@schema.rails_name.singularize}.rb"
    end

    def default_model_name
      "#{@schema.normalized_name.camelize.singularize}"
    end

    def build
      b = []
      b << "class #{@model_name} < ActiveRecord::Base"

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