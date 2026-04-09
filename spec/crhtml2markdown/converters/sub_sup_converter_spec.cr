require "../../spec_helper"

describe Crhtml2markdown::SubSupConverter do
  it "converts subscript to HTML sub tags" do
    html = "<p>H<sub>2</sub>O</p>"
    Crhtml2markdown.convert(html).should eq("H<sub>2</sub>O")
  end

  it "converts superscript to HTML sup tags" do
    html = "<p>x<sup>2</sup></p>"
    Crhtml2markdown.convert(html).should eq("x<sup>2</sup>")
  end

  it "handles mixed sub and sup" do
    html = "<p>a<sub>i</sub> + b<sup>n</sup></p>"
    Crhtml2markdown.convert(html).should eq("a<sub>i</sub> + b<sup>n</sup>")
  end
end
