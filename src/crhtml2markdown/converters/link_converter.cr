module Crhtml2markdown
  class LinkConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "a" && !!node["href"]?
    end

    def convert(node : XML::Node, io : IO) : Nil
      href = node["href"]
      text = String.build do |inner|
        node.children.each { |child| Crhtml2markdown.convert_node(child, inner) }
      end
      io << "[" << text << "](#{href})"
    end
  end
end
