require "./spec_helper"

describe Crhtml2markdown do
  it "converts HTML to text" do
    html = "<p>Hello <strong>world</strong></p>"
    Crhtml2markdown.convert(html).should eq("Hello **world**")
  end

  it "converts headings to markdown" do
    html = "" +
           "<h1>Heading 1</h1>\n" +
           "<h2>Heading 2</h2>\n" +
           "<h3>Heading 3</h3>\n" +
           "<h4>Heading 4</h4>\n" +
           "<h5>Heading 5</h5>\n" +
           "<h6>Heading 6</h6>"

    expected = "# Heading 1\n\n## Heading 2\n\n### Heading 3\n\n#### Heading 4\n\n##### Heading 5\n\n###### Heading 6"
    Crhtml2markdown.convert(html).should eq(expected)
  end

  it "converts paragraphs" do
    html = "<p>Hello</p><p>World</p>"
    Crhtml2markdown.convert(html).should eq("Hello\n\nWorld")
  end

  it "converts emphasis" do
    html = "<p>This is <em>important</em> and <strong>bold</strong></p>"
    Crhtml2markdown.convert(html).should eq("This is *important* and **bold**")
  end

  it "converts links" do
    html = "<p>Visit <a href='https://example.com'>Example</a>.</p>"
    Crhtml2markdown.convert(html).should eq("Visit [Example](https://example.com).")
  end
end
