require 'spec_helper'

module Access2rails
  module Xsd
    describe Index do
      it "should accept new with no parameters" do
        expect { Index.new }.to_not raise_error
      end
    end
  end
end
