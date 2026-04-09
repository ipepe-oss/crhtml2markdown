require "../../spec_helper"

module Crhtml2markdown
  describe TemplateConverter do
    it "hides template content" do
      html = "<p>Visible <template>Hidden</template> content</p>"
      result = convert(html)
      result.should contain("Visible")
      result.should contain("content")
      result.should_not contain("Hidden")
    end

    it "handles empty template" do
      html = "<p>Before <template></template> After</p>"
      result = convert(html)
      result.should contain("Before")
      result.should contain("After")
    end

    it "handles standalone template" do
      html = "<template>This should not appear</template>"
      result = convert(html)
      result.should eq("")
    end
  end
end
