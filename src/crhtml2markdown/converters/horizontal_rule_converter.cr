module Crhtml2markdown
  class HorizontalRuleConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "hr"
    end

    def convert(node : XML::Node, io : IO) : Nil
      io << "---\n\n"
    end
  end
end
