require 'spec_helper'
require 'ostruct'

module Access2rails
  describe ModelGenerator do

    # Create a mock of schema that contains something to generate.
    before :each do
      create_mocks
    end

    context "Class methods" do
      it "should instantiate when class method from_schema is called with empty schema" do
        @schema_mock.indices = []
        @schema_mock.columns = []
        output = ModelGenerator.from_schema(@schema_mock)
        output.class.should == ModelGenerator
      end
    end

    context "Instantiation" do
      before :all do
        create_mocks
        @model_generator = ModelGenerator.from_schema(@schema_mock)
      end

      it "should have a filename" do
        @model_generator.should respond_to :filename
        @model_generator.filename.should == "schema_name.rb"
      end

      it "should build the model as a string" do
        model = @model_generator.build
        model.should be_kind_of String
        model.include?("class SchemaName").should be_true
      end
    end

    context "Instantiated with built model" do
      before :all do
        create_mocks
        @model_generator = ModelGenerator.from_schema(@schema_mock)
        @model = @model_generator.build
      end

      it "should have class declaration that inherits from ActiveRecord::Base" do
        @model.include?("class SchemaName < ActiveRecord::Base").should be_true
      end

      it "should have validations" do
        @model.include?("validates :column1_name, :presence => true").should be_true
        @model.include?("validates :column1_name, :numericality => { :only_integer => true }").should be_true
        @model.include?("validates :column2_name, :length => { :maximum => 10 }").should be_true
      end

      it "should have XML mapping" do
        @model.include?("include ROXML").should be_true
        @model.include?("xml_accessor :column1_name").should be_true
        @model.include?("xml_accessor :column2_name").should be_true
      end

      it "should not have syntax errors" do
        expect { eval(@model) }.to_not raise_error
      end
    end

  end
end
