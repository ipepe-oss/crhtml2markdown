module Crhtml2markdown
  class SubSupConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "sub" || node.name == "sup"
    end

    def convert(node : XML::Node, io : IO) : Nil
      tag = node.name
      io << "<" << tag << ">"
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
      io << "</" << tag << ">"
    end
  end
end
