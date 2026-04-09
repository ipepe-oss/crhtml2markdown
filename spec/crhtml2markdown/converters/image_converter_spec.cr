require "../../spec_helper"

describe Crhtml2markdown::ImageConverter do
  it "converts img to markdown image" do
    html = "<img src=\"https://example.com/img.png\" alt=\"Alt text\" />"
    Crhtml2markdown.convert(html).should eq("![Alt text](https://example.com/img.png)")
  end

  it "includes title when present" do
    html = "<img src=\"https://example.com/img.png\" alt=\"Alt\" title=\"Title\" />"
    Crhtml2markdown.convert(html).should eq("![Alt](https://example.com/img.png \"Title\")")
  end

  it "handles missing alt attribute" do
    html = "<img src=\"https://example.com/img.png\" />"
    Crhtml2markdown.convert(html).should eq("![](https://example.com/img.png)")
  end

  it "converts image inside link" do
    html = "<a href=\"https://example.com\"><img src=\"https://example.com/img.png\" alt=\"Click\" /></a>"
    Crhtml2markdown.convert(html).should eq("[![Click](https://example.com/img.png)](https://example.com)")
  end
end
