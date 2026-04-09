require "../../spec_helper"

module Crhtml2markdown
  describe TimeDataConverter do
    it "converts time elements to plain text" do
      html = "<p><time datetime=\"2023-01-01\">January 1st</time></p>"
      result = convert(html)
      result.should contain("January 1st")
    end

    it "converts data elements to plain text" do
      html = "<p><data value=\"123\">Product</data></p>"
      result = convert(html)
      result.should contain("Product")
    end

    it "handles nested content" do
      html = "<time>2023</time>"
      result = convert(html)
      result.should eq("2023")
    end
  end
end
