require "../../spec_helper"

module Crhtml2markdown
  describe InsConverter do
    it "converts ins elements to insert syntax" do
      html = "<p><ins>Inserted</ins> text</p>"
      result = convert(html)
      result.should contain("++Inserted++")
    end

    it "handles nested content in ins" do
      html = "<ins>new content</ins>"
      result = convert(html)
      result.should eq("++new content++")
    end
  end
end
