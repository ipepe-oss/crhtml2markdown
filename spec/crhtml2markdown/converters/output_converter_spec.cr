require "../../spec_helper"

module Crhtml2markdown
  describe OutputConverter do
    it "converts output elements to plain text" do
      html = "<p>Result: <output>42</output></p>"
      result = convert(html)
      result.should contain("Result: 42")
    end

    it "handles nested content" do
      html = "<output>result</output>"
      result = convert(html)
      result.should eq("result")
    end
  end
end
