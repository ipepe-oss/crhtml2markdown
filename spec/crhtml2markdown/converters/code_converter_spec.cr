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

  it "uses double backticks when content contains single backtick" do
    html = "<p><code>a ` b</code></p>"
    Crhtml2markdown.convert(html).should eq("`` a ` b ``")
  end

  it "uses 4-backtick fence when code block contains triple backticks" do
    html = "<pre><code>before ``` after</code></pre>"
    Crhtml2markdown.convert(html).should eq("````\nbefore ``` after\n````")
  end

  it "uses 5-backtick fence when code block contains 4 backticks" do
    html = "<pre><code>before ```` after</code></pre>"
    Crhtml2markdown.convert(html).should eq("`````\nbefore ```` after\n`````")
  end

  it "uses standard 3-backtick fence when code has no backticks" do
    html = "<pre><code>no backticks here</code></pre>"
    Crhtml2markdown.convert(html).should eq("```\nno backticks here\n```")
  end

  it "converts inline code with newlines to single line" do
    html = "<code>line1\nline2\nline3</code>"
    Crhtml2markdown.convert(html).should eq("`line1 line2 line3`")
  end

  it "handles inline code with newlines in paragraph" do
    html = "<p>Text with <code>multi\nline</code> code</p>"
    Crhtml2markdown.convert(html).should eq("Text with `multi line` code")
  end
end
