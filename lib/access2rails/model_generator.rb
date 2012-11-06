module Access2rails
	class ModelGenerator
    def initialize
      @attribute = nil
    end

    def self.from_xml(xml)\
      self.new
    end
	end
end