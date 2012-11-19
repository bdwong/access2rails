module Access2rails::Xsd
  require "nokogiri"

  class Column
    attr_accessor :name, :minoccurs, :jet_type, :sqlSType, :type, :max_length
    include ::Access2rails::ColumnHelper

    def initialize(column_node=nil)
      return if column_node.nil?

      @name = column_node.attr("name").strip
      @minoccurs = column_node.attr("minoccurs")
      @jet_type = column_node.attr("jetType")
      @sqlSType = column_node.attr("sqlSType")
      @type = column_node.attr("type")
      @max_length = nil

      if @type.nil?
        type_node = column_node.xpath("simpleType")
        raise ParseError.new("unexpected unknown type") if type_node.count == 0
        @type = type_node.xpath("restriction").attr("base").value
        @max_length = type_node.xpath("restriction/maxLength").attr("value").value.to_i
      end
    end
  end
end
