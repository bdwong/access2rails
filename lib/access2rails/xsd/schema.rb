module Access2rails::Xsd
  require "nokogiri"

  class Schema
    attr_accessor :name, :indices, :columns
    def self.from_xml(string)
      Schema.new(string)
    end

    def initialize(string=nil)
      @name = nil
      @indices = []
      @columns = []

      return if string.nil?

      c = Nokogiri::XML.parse(string)
      c.remove_namespaces!

      # This is officially the table name. In the end, regex s/_x0020_/_/
      begin
        @name = c.xpath("/schema/element[@name='dataroot']/complexType/sequence/element").attr("ref").to_s
      rescue NoMethodError
        @name = nil
      end

      table_node = c.xpath("/schema/element[@name='#{@name}']")
      index_nodes = table_node.xpath("annotation/appinfo/index")
      @indices = index_nodes.map do |index_node|
        Index.new(index_node)
      end

      column_nodes = table_node.xpath("complexType/sequence/element")
      @columns = column_nodes.map do |col_node|
        Column.new(col_node)
      end
    end

    def rails_name
      @name.underscore.gsub(" ", "_").gsub("_x0020_", "_")
    end
  end
end
