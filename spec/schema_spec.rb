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
        @object.should respond_to :name
        @object.should respond_to :indices
        @object.should respond_to :columns
      end

      it "should have the correct name" do
        @object.name.should == "Switchboard_x0020_Items"
      end

      it "should have the correct indices" do
        @object.indices.should be_kind_of Array
        @object.indices.count.should == 1
        index = @object.indices[0]
        index.clustered?.should be_false
        index.index_key.should == "SwitchboardID ItemNumber"
        index.index_name.should == "PrimaryKey"
        index.primary?.should be_true
        index.unique?.should be_true
      end

      xit "should have the correct column count" do
        @object.columns.should be_kind_of Array
        @object.columns.count.should == 5
      end

      xit "should have the correct first column" do
        column = @object.columns[0]
        column.name.should == "SwitchboardID"
        column.jet_type.should == "longinteger"
        column.sqlSType.should == "int"
        column.type.should == "int"
      end

      it "should have the correct second column"
      it "should have the correct third column"
      it "should have the correct fourth column"
      it "should have the correct fifth column"

    end
  end
end
