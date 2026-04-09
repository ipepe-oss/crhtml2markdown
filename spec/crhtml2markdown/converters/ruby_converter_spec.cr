require "../../spec_helper"

module Crhtml2markdown
  describe RubyConverter do
    it "converts ruby annotations to parentheses format" do
      html = "<ruby>漢<rt>kan</rt>字<rt>ji</rt></ruby>"
      result = convert(html)
      result.should contain("漢(kan)字(ji)")
    end

    it "handles simple ruby" do
      html = "<ruby>東京<rt>とうきょう</rt></ruby>"
      result = convert(html)
      result.should contain("東京(とうきょう)")
    end

    it "handles ruby with base text only" do
      html = "<ruby>漢字</ruby>"
      result = convert(html)
      result.should contain("漢字")
    end
  end
end
