require 'spec_helper'

module Access2rails
  module Xsd
    describe Column do
      it "should accept new with no parameters" do
        expect { Column.new }.to_not raise_error
      end
    end
  end
end
