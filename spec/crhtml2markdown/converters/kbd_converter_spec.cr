require "../../spec_helper"

module Crhtml2markdown
  describe KbdConverter do
    it "converts kbd elements to inline code" do
      html = "<p>Press <kbd>Ctrl</kbd>+<kbd>C</kbd></p>"
      result = convert(html)
      result.should contain("Press `Ctrl`+`C`")
    end

    it "handles nested content in kbd" do
      html = "<kbd>Ctrl</kbd>"
      result = convert(html)
      result.should eq("`Ctrl`")
    end
  end
end
