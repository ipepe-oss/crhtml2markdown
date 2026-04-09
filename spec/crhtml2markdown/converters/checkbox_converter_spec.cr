require "../../spec_helper"

describe Crhtml2markdown::CheckboxConverter do
  it "converts checked checkbox" do
    html = "<ul><li><input checked=\"\" disabled=\"\" type=\"checkbox\"> Done</li></ul>"
    Crhtml2markdown.convert(html).should eq("- [x] Done")
  end

  it "converts unchecked checkbox" do
    html = "<ul><li><input disabled=\"\" type=\"checkbox\"> Todo</li></ul>"
    Crhtml2markdown.convert(html).should eq("- [ ] Todo")
  end

  it "converts a task list with mixed states" do
    html = "<ul><li><input checked=\"\" disabled=\"\" type=\"checkbox\"> A</li><li><input disabled=\"\" type=\"checkbox\"> B</li></ul>"
    Crhtml2markdown.convert(html).should eq("- [x] A\n- [ ] B")
  end
end
