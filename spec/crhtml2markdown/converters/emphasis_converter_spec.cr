require "../../spec_helper"

describe Crhtml2markdown::EmphasisConverter do
  it "converts em to single asterisks" do
    html = "<p><em>italic</em></p>"
    Crhtml2markdown.convert(html).should eq("*italic*")
  end

  it "converts strong to double asterisks" do
    html = "<p><strong>bold</strong></p>"
    Crhtml2markdown.convert(html).should eq("**bold**")
  end

  it "handles nested emphasis" do
    html = "<p><strong>bold and <em>italic</em></strong></p>"
    Crhtml2markdown.convert(html).should eq("**bold and *italic***")
  end
end
