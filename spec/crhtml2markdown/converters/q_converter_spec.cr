require "../../spec_helper"
require "../../../src/crhtml2markdown/converters/q_converter"

module Crhtml2markdown
  describe QConverter do
    it "converts q elements to double-quoted text" do
      html = "<p>He said <q>Hello</q></p>"
      result = Crhtml2markdown.convert(html)
      result.should contain("\"Hello\"")
    end

    it "handles nested inline elements in q" do
      html = "<p>He said <q>Hello <em>there</em></q></p>"
      result = Crhtml2markdown.convert(html)
      result.should contain("\"Hello *there*\"")
    end

    it "handles multiple q elements" do
      html = "<p><q>First</q> and <q>Second</q></p>"
      result = Crhtml2markdown.convert(html)
      result.should contain("\"First\"")
      result.should contain("\"Second\"")
    end
  end
end
