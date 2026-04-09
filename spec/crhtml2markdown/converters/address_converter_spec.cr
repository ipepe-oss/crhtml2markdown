require "../../spec_helper"

module Crhtml2markdown
  describe AddressConverter do
    it "converts address elements to code block" do
      html = "<address>123 Main St</address>"
      result = convert(html)
      result.should contain("```")
      result.should contain("123 Main St")
    end

    it "handles multiline addresses" do
      html = "<address>123 Main Street<br>City, State 12345</address>"
      result = convert(html)
      result.should contain("```")
      result.should contain("123 Main Street")
      result.should contain("City, State 12345")
    end

    it "handles simple address" do
      html = "<address>simple</address>"
      result = convert(html)
      result.should contain("simple")
    end
  end
end
