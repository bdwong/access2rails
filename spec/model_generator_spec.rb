require 'spec_helper'

module Access2rails
  describe ModelGenerator do
    context "Class methods" do
      it "should instantiate when called with class method from_xml" do
        output = ModelGenerator.from_xml("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<root/>")
        output.class.should == ModelGenerator
      end
    end
  end
end
