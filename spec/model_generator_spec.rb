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

      subject(:model_generator) { @model_generator }

      its(:filename) { should == "schema_name.rb" }

      it "should build the model as a string" do
        model = model_generator.build
        model.should be_kind_of String
        model.should match "class SchemaName"
      end
    end

    context "Instantiated with built model" do
      before :all do
        create_mocks
        @model_generator = ModelGenerator.from_schema(@schema_mock)
        @model = @model_generator.build
      end

      subject(:model) { @model }

      it "should have class declaration that inherits from ActiveRecord::Base" do
        model.should match "class SchemaName < ActiveRecord::Base"
      end

      context "validations" do
        it {should match "validates :column1_name, :presence => true"}
        it {should match "validates :column1_name, :numericality => { :only_integer => true }"}
        it {should match "validates :column2_name, :length => { :maximum => 10 }"}
      end

      context "XML mapping" do
        it {should match "include ROXML"}
        it {should match "xml_accessor :column1_name"}
        it {should match "xml_accessor :column2_name"}
      end

      it "should not have syntax errors" do
        expect { eval(model) }.to_not raise_error
      end
    end

    describe :default_model_name do
      it "should be singular schema.normalized_name" do
        @schema_mock.name = "Entities"
        @model_generator = ModelGenerator.from_schema(@schema_mock)
        @model_generator.default_model_name.should == "Entity"
      end

      it "should have underscores minimized" do
        @schema_mock.name = "My_Test_x0020_name"
        @model_generator = ModelGenerator.from_schema(@schema_mock)
        @model_generator.default_model_name.should == "MyTestName"
      end
    end

    describe :default_filename do
      it "should be singular schema.rails_name with .rb appended" do
        @schema_mock.name = "Entities"
        @model_generator = ModelGenerator.from_schema(@schema_mock)
        @model_generator.default_filename.should == "entity.rb"

        @schema_mock.name = "test_x0020_name"
        @model_generator = ModelGenerator.from_schema(@schema_mock)
        @model_generator.default_filename.should == "test_name.rb"
      end
    end

    describe :filename do
      it "should be default_filename when instantiated" do
        @schema_mock.name = "test_name"
        @model_generator = ModelGenerator.from_schema(@schema_mock)
        @model_generator.default_filename.should == "test_name.rb"
        @model_generator.filename.should == "test_name.rb"
      end

      it "should not change if schema_name changes" do
        @schema_mock.name = "test_name"
        @model_generator = ModelGenerator.from_schema(@schema_mock)
        @model_generator.filename.should == "test_name.rb"
        @schema_mock.name = "SomeOtherName"
        @model_generator.filename.should == "test_name.rb"
      end
    end

  end
end
