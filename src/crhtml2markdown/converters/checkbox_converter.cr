module Crhtml2markdown
  class CheckboxConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "input" && node["type"]? == "checkbox"
    end

    def convert(node : XML::Node, io : IO) : Nil
      if node["checked"]?
        io << "[x]"
      else
        io << "[ ]"
      end
    end
  end
end
