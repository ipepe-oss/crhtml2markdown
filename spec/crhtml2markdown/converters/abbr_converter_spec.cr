require "../../spec_helper"

module Crhtml2markdown
  describe AbbrConverter do
    it "converts abbr elements with title" do
      html = "<p><abbr title=\"Graphical User Interface\">GUI</abbr></p>"
      result = convert(html)
      result.should contain("GUI (Graphical User Interface)")
    end

    it "converts abbr elements without title" do
      html = "<abbr>HTML</abbr>"
      result = convert(html)
      result.should contain("HTML")
    end

    it "handles nested content" do
      html = "<abbr title=\"Test\">T</abbr>"
      result = convert(html)
      result.should eq("T (Test)")
    end
  end
end
