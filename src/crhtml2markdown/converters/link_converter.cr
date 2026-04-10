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
      if title = node["title"]?
        escaped_title = title.gsub('"', "\\\"")
        io << "[" << text << "](#{href} \"#{escaped_title}\")"
      else
        io << "[" << text << "](#{href})"
      end
    end
  end
end
