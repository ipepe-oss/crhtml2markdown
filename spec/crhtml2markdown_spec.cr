require "./spec_helper"

describe Crhtml2markdown do
  it "converts HTML to text" do
    html = "<p>Hello <strong>world</strong></p>"
    Crhtml2markdown.convert(html).should eq("Hello world")
  end
end
