require "../../spec_helper"

describe Crhtml2markdown::BlockContainerConverter do
  it "converts div as transparent block container" do
    html = "<div><h2>Title</h2><p>Content</p></div>"
    Crhtml2markdown.convert(html).should eq("## Title\n\nContent")
  end

  it "converts section elements" do
    html = "<section><h3>Section</h3><p>Paragraph</p></section>"
    Crhtml2markdown.convert(html).should eq("### Section\n\nParagraph")
  end

  it "converts article elements" do
    html = "<article><p>Article content.</p></article>"
    Crhtml2markdown.convert(html).should eq("Article content.")
  end

  it "converts nav elements" do
    html = "<nav><a href=\"/home\">Home</a></nav>"
    Crhtml2markdown.convert(html).should eq("[Home](/home)")
  end

  it "converts header elements" do
    html = "<header><h1>Page Title</h1></header>"
    Crhtml2markdown.convert(html).should eq("# Page Title")
  end

  it "converts footer elements" do
    html = "<footer><p>Footer text</p></footer>"
    Crhtml2markdown.convert(html).should eq("Footer text")
  end

  it "converts address elements" do
    html = "<address>Contact: <a href=\"mailto:a@b.com\">a@b.com</a></address>"
    Crhtml2markdown.convert(html).should eq("Contact: [a@b.com](mailto:a@b.com)")
  end

  it "separates consecutive block containers" do
    html = "<div><p>First</p></div><div><p>Second</p></div>"
    Crhtml2markdown.convert(html).should eq("First\n\nSecond")
  end

  it "skips empty containers" do
    html = "<div>  </div><p>After</p>"
    Crhtml2markdown.convert(html).should eq("After")
  end

  it "converts main element" do
    html = "<main><p>Main content</p></main>"
    Crhtml2markdown.convert(html).should eq("Main content")
  end

  it "converts aside element" do
    html = "<aside><p>Sidebar content</p></aside>"
    Crhtml2markdown.convert(html).should eq("Sidebar content")
  end
end
