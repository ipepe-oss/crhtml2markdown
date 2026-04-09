require "../../spec_helper"

describe Crhtml2markdown::InlineHtmlPassthroughConverter do
  it "passes through <mark> tags" do
    html = "<p><mark>highlighted text</mark></p>"
    Crhtml2markdown.convert(html).should eq("<mark>highlighted text</mark>")
  end

  it "passes through <kbd> tags" do
    html = "<p>Press <kbd>Ctrl</kbd> + <kbd>C</kbd></p>"
    Crhtml2markdown.convert(html).should eq("Press <kbd>Ctrl</kbd> + <kbd>C</kbd>")
  end

  it "passes through <ins> tags" do
    html = "<p><ins>inserted text</ins></p>"
    Crhtml2markdown.convert(html).should eq("<ins>inserted text</ins>")
  end

  it "passes through <u> tags" do
    html = "<p><u>underlined text</u></p>"
    Crhtml2markdown.convert(html).should eq("<u>underlined text</u>")
  end

  it "passes through <small> tags" do
    html = "<p><small>small text</small></p>"
    Crhtml2markdown.convert(html).should eq("<small>small text</small>")
  end

  it "passes through <abbr> with title attribute" do
    html = "<p><abbr title=\"Hyper Text Markup Language\">HTML</abbr></p>"
    Crhtml2markdown.convert(html).should eq("<abbr title=\"Hyper Text Markup Language\">HTML</abbr>")
  end

  it "converts inline markdown inside passthrough tags" do
    html = "<p><mark><strong>bold highlighted</strong></mark></p>"
    Crhtml2markdown.convert(html).should eq("<mark>**bold highlighted**</mark>")
  end
end
