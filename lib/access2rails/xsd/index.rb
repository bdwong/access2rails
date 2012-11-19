module Access2rails::Xsd
  require "nokogiri"

  class Index
    attr_accessor :clustered, :index_key, :index_name, :primary, :unique
    include ::Access2rails::IndexHelper

    def initialize(index_node=nil)
      return if index_node.nil?

      @clustered = index_node.attr("clustered")
      @index_key = index_node.attr("index-key").strip
      @index_name = index_node.attr("index-name").strip
      @primary = index_node.attr("primary")
      @unique = index_node.attr("unique")
    end
  end
end
