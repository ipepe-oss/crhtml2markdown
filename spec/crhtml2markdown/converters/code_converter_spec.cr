require "../../spec_helper"

describe Crhtml2markdown::CodeConverter do
  it "converts inline code to backticks" do
    html = "<p>Use <code>puts</code> to print</p>"
    Crhtml2markdown.convert(html).should eq("Use `puts` to print")
  end

  it "converts code blocks to fenced code" do
    html = "<pre><code>hello\nworld</code></pre>"
    Crhtml2markdown.convert(html).should eq("```\nhello\nworld\n```")
  end

  it "preserves language class on fenced code blocks" do
    html = "<pre><code class=\"language-ruby\">puts \"hello\"</code></pre>"
    Crhtml2markdown.convert(html).should eq("```ruby\nputs \"hello\"\n```")
  end

  it "handles code blocks without language" do
    html = "<pre><code>some code</code></pre>"
    Crhtml2markdown.convert(html).should eq("```\nsome code\n```")
  end

  it "handles inline code inside paragraphs with surrounding text" do
    html = "<p>Use <code>+</code>, <code>-</code>, or <code>*</code></p>"
    Crhtml2markdown.convert(html).should eq("Use `+`, `-`, or `*`")
  end
end
