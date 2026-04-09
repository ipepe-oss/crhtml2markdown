require "../../spec_helper"

module Crhtml2markdown
  describe BidiConverter do
    it "converts bdi elements to plain text" do
      html = "<p><bdi>עברית</bdi> text</p>"
      result = convert(html)
      result.should contain("עברית text")
    end

    it "converts bdo elements to plain text" do
      html = "<p><bdo dir=\"rtl\">Right to left</bdo></p>"
      result = convert(html)
      result.should contain("Right to left")
    end

    it "handles nested content" do
      html = "<bdi>text</bdi>"
      result = convert(html)
      result.should eq("text")
    end
  end
end
