require 'spec_helper'
require 'ostruct'

module Access2rails
  class TestColumn
    attr_accessor :name, :minoccurs, :jet_type, :sqlSType, :type, :max_length
    include ColumnHelper
  end

  describe TestColumn do
    context "Instantiation" do
      it "should instantiate TestColumn with no parameters" do
        expect { TestColumn.new }.to_not raise_error
      end

      it "should instantiate TestColumn.from_hash with empty hash" do
        expect {
          TestColumn.from_hash({}).should be_an_instance_of TestColumn
          }.to_not raise_error
      end

      it "should instantiate TestColumn.from_hash with arguments" do
        expect {
          TestColumn.from_hash(:name => "value").should be_an_instance_of TestColumn
          }.to_not raise_error
      end

      it "should raise if hash key is not an attribute" do
        expect { TestColumn.from_hash(:unknown_attr => "value")}.to raise_error(ArgumentError)
      end
    end

    describe :rails_type do
      it "should convert xsd:int to integer" do
        c = TestColumn.from_hash({:type => "xsd:int"})
        c.rails_type.should == "integer"
      end

      it "should convert xsd:short to integer" do
        c = TestColumn.from_hash({:type => "xsd:short"})
        c.rails_type.should == "integer"
      end

      it "should convert xsd:string to string" do
        c = TestColumn.from_hash({:type => "xsd:string"})
        c.rails_type.should == "string"
      end

      it "should convert xsd:boolean to boolean" do
        c = TestColumn.from_hash({:type => "xsd:boolean"})
        c.rails_type.should == "boolean"
      end

      it "should convert xsd:dateTime to datetime" do
        c = TestColumn.from_hash({:type => "xsd:datetime"})
        c.rails_type.should == "datetime"
      end

      it "should convert xsd:double to float" do
        c = TestColumn.from_hash({:type => "xsd:double"})
        c.rails_type.should == "float"
      end

      it "should convert jet_type: currency to decimal" do
        c = TestColumn.from_hash({:type => "xsd:double", :jet_type => "currency"})
        c.rails_type.should == "decimal"
      end

      it "should convert sqlSType: money to decimal" do
        c = TestColumn.from_hash({:type => "xsd:double", :sqlSType => "money"})
        c.rails_type.should == "decimal"
      end


      it "should raise ArgumentError on unknown type" do
        c = TestColumn.from_hash({:type => "xsd:unknown_type"})
        expect {
          c.rails_type
          }.to raise_error ArgumentError
      end

    end

    describe :rails_column_name do
      it "should convert column name to snake case" do
        c = TestColumn.from_hash({:name => "ColumnName"})
        c.rails_column_name.should == "column_name"
      end

      it "should replace spaces with underscore" do
        c = TestColumn.from_hash({:name => "Column Name"})
        c.rails_column_name.should == "column_name"
      end

      it "should replace _x0020_ with underscore" do
        c = TestColumn.from_hash({:name => "COLUMN_0x0020_NAME"})
        c.rails_column_name.should == "column_name"
      end
    end

    #context "migration column generation" do
    describe :definition do
      it "should include the column name" do
        t = TestColumn.from_hash(:name => "my_column", :type => "xsd:string")
        t.definition.should include(':my_column')
      end

      it "should include the correct type" do
        t = TestColumn.from_hash(:name => "my_column", :type => "xsd:string")
        t.definition.should include('t.string')
      end

      it "should include :precision and :scale for money type." do
        t = TestColumn.from_hash({:name => "my_column", :type => "xsd:double", :jet_type => "currency"})
        t.definition.should include(':precision => 15, :scale => 2')
      end

    end
  end

end
