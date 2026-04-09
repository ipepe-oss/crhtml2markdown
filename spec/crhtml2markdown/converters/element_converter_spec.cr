require "../../spec_helper"

describe Crhtml2markdown::ElementConverter do
  it "is the abstract base class for all converters" do
    # ElementConverter is abstract and cannot be instantiated directly.
    # This test verifies that concrete converters inherit from it.
    converter = Crhtml2markdown::HeadingConverter.new
    converter.is_a?(Crhtml2markdown::ElementConverter).should be_true
  end
end
