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
        expect { TestColumn.from_hash({}) }.to_not raise_error
      end

      it "should instantiate TestColumn.from_hash with arguments" do
        expect {
          TestColumn.from_hash(:name => "value")
          }.to_not raise_error
      end

      it "should raise if hash key is not an attribute" do
        expect { TestColumn.from_hash(:unknown_attr => "value")}.to raise_error(ArgumentError)
      end
    end

    context "column generation" do
      it "should include the table name"
      it "should include the column name"
      it "should include the correct type"
      it "should deal with :precision and :scale for money and decimal types."
    end
  end

end
