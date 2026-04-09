require "../../spec_helper"

describe Crhtml2markdown::HeadingConverter do
  it "converts all heading levels" do
    (1..6).each do |level|
      html = "<h#{level}>Heading #{level}</h#{level}>"
      expected = "#{"#" * level} Heading #{level}"
      Crhtml2markdown.convert(html).should eq(expected)
    end
  end

  it "strips whitespace from heading content" do
    html = "<h1>  Spaced  </h1>"
    Crhtml2markdown.convert(html).should eq("# Spaced")
  end

  it "preserves inline code in headings" do
    html = "<h2>Heading with <code>code</code></h2>"
    Crhtml2markdown.convert(html).should eq("## Heading with `code`")
  end

  it "preserves bold in headings" do
    html = "<h2>Heading with <strong>bold</strong></h2>"
    Crhtml2markdown.convert(html).should eq("## Heading with **bold**")
  end

  it "preserves multiple inline elements in headings" do
    html = "<h3>With <code>code</code> and <em>italic</em> and <strong>bold</strong></h3>"
    Crhtml2markdown.convert(html).should eq("### With `code` and *italic* and **bold**")
  end

  it "preserves links in headings" do
    html = "<h2>See <a href=\"https://example.com\">docs</a></h2>"
    Crhtml2markdown.convert(html).should eq("## See [docs](https://example.com)")
  end
end
