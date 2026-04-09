require "../../spec_helper"

module Crhtml2markdown
  describe MarkConverter do
    it "converts mark elements to highlight syntax" do
      html = "<p>Marked <mark>text</mark></p>"
      result = convert(html)
      result.should contain("==text==")
    end

    it "handles nested content in mark" do
      html = "<mark>important</mark>"
      result = convert(html)
      result.should eq("==important==")
    end
  end
end
