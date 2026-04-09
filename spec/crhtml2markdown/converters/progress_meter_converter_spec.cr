require "../../spec_helper"

module Crhtml2markdown
  describe ProgressMeterConverter do
    it "converts progress elements with value" do
      html = "<p>Progress: <progress value=\"70\" max=\"100\"></progress></p>"
      result = convert(html)
      result.should contain("70%")
    end

    it "converts meter elements with value" do
      html = "<p>Meter: <meter value=\"0.7\" min=\"0\" max=\"1\">70%</meter></p>"
      result = convert(html)
      result.should contain("70%")
    end

    it "handles progress without value" do
      html = "<progress></progress>"
      result = convert(html)
      result.should contain("...")
    end
  end
end
