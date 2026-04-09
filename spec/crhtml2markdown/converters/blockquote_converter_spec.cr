require "../../spec_helper"

describe Crhtml2markdown::BlockquoteConverter do
  it "converts simple blockquote" do
    html = "<blockquote><p>Quote text</p></blockquote>"
    Crhtml2markdown.convert(html).should eq("> Quote text")
  end

  it "converts blockquote with emphasis" do
    html = "<blockquote><p>You can <em>put</em> <strong>Markdown</strong> here.</p></blockquote>"
    Crhtml2markdown.convert(html).should eq("> You can *put* **Markdown** here.")
  end

  it "converts nested blockquotes" do
    html = "<blockquote><p>Outer</p><blockquote><p>Inner</p></blockquote></blockquote>"
    Crhtml2markdown.convert(html).should eq("> Outer\n> \n> > Inner")
  end
end
