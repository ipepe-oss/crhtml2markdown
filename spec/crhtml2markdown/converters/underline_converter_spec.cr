require "../../spec_helper"

module Crhtml2markdown
  describe UnderlineConverter do
    it "passes through u elements as HTML" do
      html = "<p><u>Underlined</u> text</p>"
      result = convert(html)
      result.should contain("<u>Underlined</u>")
      result.should contain("text")
    end

    it "handles nested content" do
      html = "<u>emphasis</u>"
      result = convert(html)
      result.should eq("<u>emphasis</u>")
    end
  end
end
