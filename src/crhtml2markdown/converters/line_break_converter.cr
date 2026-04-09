module Crhtml2markdown
  class LineBreakConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "br"
    end

    def convert(node : XML::Node, io : IO) : Nil
      io << "  \n"
    end
  end
end
