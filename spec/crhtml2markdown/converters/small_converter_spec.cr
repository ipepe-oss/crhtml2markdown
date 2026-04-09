require "../../spec_helper"

module Crhtml2markdown
  describe SmallConverter do
    it "passes through small elements as HTML" do
      html = "<p><small>Small text</small></p>"
      result = convert(html)
      result.should contain("<small>Small text</small>")
    end

    it "handles nested content" do
      html = "<small>tiny</small>"
      result = convert(html)
      result.should eq("<small>tiny</small>")
    end
  end
end
