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

  it "converts b tag to double asterisks" do
    html = "<p><b>bold</b></p>"
    Crhtml2markdown.convert(html).should eq("**bold**")
  end

  it "converts i tag to single asterisks" do
    html = "<p><i>italic</i></p>"
    Crhtml2markdown.convert(html).should eq("*italic*")
  end

  it "uses alternate markers for consecutive em elements" do
    html = "<p><em>one</em><em>two</em></p>"
    Crhtml2markdown.convert(html).should eq("*one*_two_")
  end

  it "uses alternate markers for consecutive strong elements" do
    html = "<p><strong>one</strong><strong>two</strong></p>"
    Crhtml2markdown.convert(html).should eq("**one**__two__")
  end

  it "uses alternate markers for mixed consecutive emphasis" do
    html = "<p><em>one</em><strong>two</strong></p>"
    Crhtml2markdown.convert(html).should eq("*one*__two__")
  end
end
