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

        its(:filename) { should == "20120301182403_create_schema_name.rb"}
        its(:timestamp) { should == "20120301182403" }
      end
    end

  end
end
