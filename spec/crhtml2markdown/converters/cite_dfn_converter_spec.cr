require "../../spec_helper"

module Crhtml2markdown
  describe CiteDfnConverter do
    it "converts cite elements to italics" do
      html = "<p><cite>The Odyssey</cite> by Homer</p>"
      result = convert(html)
      result.should contain("*The Odyssey*")
    end

    it "converts dfn elements to italics" do
      html = "<p><dfn>HTML</dfn> is the standard...</p>"
      result = convert(html)
      result.should contain("*HTML*")
    end

    it "handles nested content" do
      html = "<cite>work</cite>"
      result = convert(html)
      result.should eq("*work*")
    end
  end
end
