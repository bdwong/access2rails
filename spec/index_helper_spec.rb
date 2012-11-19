require 'spec_helper'
require 'ostruct'

module Access2rails
  class TestIndex
    attr_accessor :clustered, :index_key, :index_name, :primary, :unique
    include IndexHelper
  end

  describe TestIndex do
    context "Instantiation" do
      it "should instantiate TestIndex with no parameters" do
        expect { TestIndex.new }.to_not raise_error
      end

      it "should instantiate TestIndex.from_hash with empty hash" do
        expect {
          TestIndex.from_hash({}).should be_an_instance_of TestIndex
          }.to_not raise_error
      end

      it "should instantiate TestIndex.from_hash with arguments" do
        expect {
          TestIndex.from_hash(:index_name => "value").should be_an_instance_of TestIndex
          }.to_not raise_error
      end

      it "should raise if hash key is not an attribute" do
        expect { TestIndex.from_hash(:unknown_attr => "value")}.to raise_error(ArgumentError)
      end
    end

    describe :unique? do
      it "should reflect the @unique attribute" do
        i = TestIndex.new
        i.unique = nil
        i.should_not be_unique
        i.unique = "no"
        i.should_not be_unique
        i.unique = "yes"
        i.should be_unique
      end
    end

    describe :primary? do
      it "should reflect the @primary attribute" do
        i = TestIndex.new
        i.primary = nil
        i.should_not be_primary
        i.primary = "no"
        i.should_not be_primary
        i.primary = "yes"
        i.should be_primary
      end
    end

    describe :clustered? do
      it "should reflect the @clustered attribute" do
        i = TestIndex.new
        i.clustered = nil
        i.should_not be_clustered
        i.clustered = "no"
        i.should_not be_clustered
        i.clustered = "yes"
        i.should be_clustered
      end
    end

    describe :index_columns do
      it "should return single index column" do
        i = TestIndex.from_hash(:index_key => 'single_column ')
        i.index_columns.should == ':single_column'
      end

      it "should return multiple index columns in an array" do
        i = TestIndex.from_hash(:index_key => 'column1 column2 ')
        i.index_columns.should == '[:column1, :column2]'
      end
    end

    describe :definition do
      it "should include the table name" do
        i = TestIndex.from_hash(:index_key => 'key')
        i.definition('table_name').should include('add_index :table_name')
      end

      it "should include the index column name" do
        i = TestIndex.from_hash(:index_key => 'single_column ')
        i.definition('table_name').should include('add_index :table_name, :single_column')
      end

      it "should include multiple index columns in an array" do
        i = TestIndex.from_hash(:index_key => 'column_a column_b ')
        i.definition('table_name').should include('add_index :table_name, [:column_a, :column_b]')
      end

      it "should include :unique => true if the key is unique" do
        i = TestIndex.from_hash(:index_key => 'key ', :unique => 'yes')
        i.definition('table_name').should include('add_index :table_name, :key, :unique => true')
      end

      #TODO: make using the index_name optional. Currently we don't use it.
      # it "should use :index_name if present"
      # it "should not use :index_name if configured off"

    end

  end

end
