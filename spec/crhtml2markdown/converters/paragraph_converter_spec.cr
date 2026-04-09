require "../../spec_helper"

describe Crhtml2markdown::ParagraphConverter do
  it "converts paragraphs with double newlines" do
    html = "<p>Hello</p><p>World</p>"
    Crhtml2markdown.convert(html).should eq("Hello\n\nWorld")
  end

  it "preserves inline elements inside paragraphs" do
    html = "<p>Text with <em>emphasis</em></p>"
    Crhtml2markdown.convert(html).should eq("Text with *emphasis*")
  end
end
