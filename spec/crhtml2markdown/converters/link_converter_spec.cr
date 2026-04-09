require "../../spec_helper"

describe Crhtml2markdown::LinkConverter do
  it "converts links to markdown format" do
    html = "<a href=\"https://example.com\">Example</a>"
    Crhtml2markdown.convert(html).should eq("[Example](https://example.com)")
  end

  it "handles links with inline elements" do
    html = "<a href=\"https://example.com\"><strong>Bold Link</strong></a>"
    Crhtml2markdown.convert(html).should eq("[**Bold Link**](https://example.com)")
  end

  it "includes title attribute when present" do
    html = "<a href=\"https://www.google.com\" title=\"Google's Homepage\">Google</a>"
    Crhtml2markdown.convert(html).should eq("[Google](https://www.google.com \"Google's Homepage\")")
  end

  it "omits title when not present" do
    html = "<a href=\"https://example.com\">Example</a>"
    Crhtml2markdown.convert(html).should eq("[Example](https://example.com)")
  end
end
