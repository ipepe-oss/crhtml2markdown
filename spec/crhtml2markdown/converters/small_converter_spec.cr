require "../../spec_helper"

module Crhtml2markdown
  describe SmallConverter do
    it "converts small elements to plain text" do
      html = "<p><small>Small text</small></p>"
      result = convert(html)
      result.should contain("Small text")
    end

    it "handles nested content" do
      html = "<small>tiny</small>"
      result = convert(html)
      result.should eq("tiny")
    end
  end
end
