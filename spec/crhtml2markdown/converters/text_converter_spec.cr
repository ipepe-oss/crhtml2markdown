require "../../spec_helper"

describe Crhtml2markdown::TextConverter do
  it "preserves text content" do
    html = "<p>Simple text</p>"
    Crhtml2markdown.convert(html).should eq("Simple text")
  end

  it "preserves spaces between inline elements" do
    html = "<p><em>italic</em> <strong>bold</strong></p>"
    Crhtml2markdown.convert(html).should eq("*italic* **bold**")
  end
end
