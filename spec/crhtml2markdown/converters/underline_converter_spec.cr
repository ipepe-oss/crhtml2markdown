require "../../spec_helper"

module Crhtml2markdown
  describe UnderlineConverter do
    it "converts u elements to plain text" do
      html = "<p><u>Underlined</u> text</p>"
      result = convert(html)
      result.should contain("Underlined text")
    end

    it "handles nested content" do
      html = "<u>emphasis</u>"
      result = convert(html)
      result.should eq("emphasis")
    end
  end
end
