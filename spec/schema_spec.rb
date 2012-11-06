require 'spec_helper'

module Access2rails::Xsd
  describe Schema do
    context "Class methods" do
      it "should instantiate when called with class method from_xml" do
        object = Schema.from_xml("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<schema/>")
        object.class.should == Schema
      end
    end

    it "should parse Switchboard Items.xsd example" do
      object = Schema.from_xml(File.read(File.join(Access2rails::PROJECT_DIR, 'examples', 'Switchboard Items.xsd')))
      object.class.should == Schema
    end

    context "Instantiate Switchboard Items example" do
      before :all do
        @object = Schema.from_xml(File.read(File.join(Access2rails::PROJECT_DIR, 'examples', 'Switchboard Items.xsd')))
      end

      it "should have the correct attributes" do
        @object.should respond_to :elements
        @object.elements.should be_kind_of Array
        @object.elements.size.should == 2
        @object.elements.each do |e|
          e.should be_kind_of Element
        end
      end
    end
  end
end
