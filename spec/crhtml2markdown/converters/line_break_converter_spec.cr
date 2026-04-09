require "../../spec_helper"

describe Crhtml2markdown::LineBreakConverter do
  it "converts br to trailing spaces and newline" do
    html = "<p>first<br>second</p>"
    Crhtml2markdown.convert(html).should eq("first  \nsecond")
  end

  it "handles multiple line breaks" do
    html = "<p>a<br>b<br>c</p>"
    Crhtml2markdown.convert(html).should eq("a  \nb  \nc")
  end
end
