module Access2rails::Xsd
  require "nokogiri"

  class Index
    attr_accessor :clustered, :index_key, :index_name, :primary, :unique

    def initialize(index_node)
      @clustered = (index_node.attr("clustered") == "yes")
      @index_key = index_node.attr("index-key").strip
      @index_name = index_node.attr("index-name").strip
      @primary = (index_node.attr("primary") == "yes")
      @unique = (index_node.attr("unique") == "yes")
    end

    def clustered?
      !!@clustered
    end

    def primary?
      !!@primary
    end

    def unique?
      !!@unique
    end

  end
end
