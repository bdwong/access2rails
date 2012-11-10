module Access2rails::Xsd
  require "nokogiri"

  class Schema
    attr_accessor :name, :indices, :columns
    def self.from_xml(string)
      Schema.new(string)
    end

    def initialize(string)
      @name = nil
      @indices = []
      @columns = []

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
      index_nodes.each do |index_node|
        @indices << Index.new(index_node)
      end
    end
  end
end
