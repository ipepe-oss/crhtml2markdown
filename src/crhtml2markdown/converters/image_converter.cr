module Crhtml2markdown
  class ImageConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "img" && !!node["src"]?
    end

    def convert(node : XML::Node, io : IO) : Nil
      src = node["src"]
      alt = node["alt"]? || ""
      title = node["title"]?
      io << "![" << alt << "](" << src
      if title
        io << " \"" << title << "\""
      end
      io << ")"
    end
  end
end
