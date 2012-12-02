require 'spec_helper'
require 'ostruct'

module Access2rails
  describe MigrationGenerator do
    # Create a mock of schema that contains something to generate.
    before :each do
      create_mocks
    end

    context "Class methods" do
      it "should instantiate when class method from_schema is called with empty schema" do
        @schema_mock.indices = []
        @schema_mock.columns = []
        output = MigrationGenerator.from_schema(@schema_mock)
        output.class.should == MigrationGenerator
      end
    end

    context "Instantiation" do
      before :all do
        create_mocks
        @schema_mock.indices = []
        @schema_mock.columns = []
        @migration_generator = MigrationGenerator.from_schema(@schema_mock)
      end

      subject(:migration_generator) { @migration_generator }

      it { should respond_to :name }
      it { should respond_to :timestamp }
      it { should respond_to :filename}

      it "should build the migration as a string" do
        migration = migration_generator.build
        migration.should be_kind_of String
        migration.should match "class CreateSchemaName"
      end
    end

    context "Attributes" do
      before :all do
        create_mocks
        @schema_mock.indices = []
        @schema_mock.columns = []
      end

      describe :default_filename do
        it "should follow correct rails migration naming" do
          @schema_mock.name = "Entities"
          @migration_generator = MigrationGenerator.from_schema(@schema_mock)
          @migration_generator.timestamp = "yymmddHHMMSS"
          @migration_generator.default_filename.should == "yymmddHHMMSS_create_entities.rb"

          @schema_mock.name = "test_x0020_name"
          @migration_generator = MigrationGenerator.from_schema(@schema_mock)
          @migration_generator.timestamp = "yymmddHHMMSS"
          @migration_generator.default_filename.should == "yymmddHHMMSS_create_test_names.rb"
        end
      end

      describe :filename do
        it "should be default_filename when instantiated" do
          @schema_mock.name = "test_name"
          @migration_generator = MigrationGenerator.from_schema(@schema_mock)
          @migration_generator.timestamp = "yymmddHHMMSS"
          @migration_generator.default_filename.should == "yymmddHHMMSS_create_test_names.rb"
          @migration_generator.filename.should == "yymmddHHMMSS_create_test_names.rb"
        end

        it "should not change if schema_name changes" do
          @schema_mock.name = "test_name"
          @migration_generator = MigrationGenerator.from_schema(@schema_mock)
          @migration_generator.timestamp = "yymmddHHMMSS"
          @migration_generator.filename.should == "yymmddHHMMSS_create_test_names.rb"
          @schema_mock.name = "SomeOtherName"
          @migration_generator.filename.should == "yymmddHHMMSS_create_test_names.rb"
        end
      end
    end

    context "Frozen in time" do
      before(:all) { Timecop.freeze(Time.local(2012, 3, 1, 18, 24, 3)) }
      after(:all) { Timecop.return }

      context "Instance methods" do
        let (:migration_generator) { @migration_generator = MigrationGenerator.from_schema(@schema_mock) }
        subject { migration_generator }

        it "should have a migration name that matches the schema name" do
          migration_generator.name.should == "SchemaName"
          migration_generator.name.should == @schema_mock.name
        end

        its(:filename) { should == "20120301182403_create_schema_names.rb"}
        its(:timestamp) { should == "20120301182403" }
      end
    end

    context "Instantiated with built migration" do
      let (:migration_generator) { @migration_generator = MigrationGenerator.from_schema(@schema_mock) }
      let (:migration) { @migration = migration_generator.build }
      subject { migration }

      it "should have class declaration that inherits from ActiveRecord::Migration" do
        migration.should match "class CreateSchemaName < ActiveRecord::Migration"
      end

      context "table definition" do
        it {should match /create_table :schema_names do \|t\|/}
      end

      context "column definition" do
        it {should match "t.integer :column1_name"}
        it {should match "t.string :column2_name, :limit => 10"}
      end

      context "indices" do
        it {should match "add_index :schema_names, :column1_name, :unique => true"}
      end

      it "should not have syntax errors" do
        expect { eval(migration) }.to_not raise_error
      end

    end
  end
end
