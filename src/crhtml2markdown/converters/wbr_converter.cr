module Crhtml2markdown
  class WbrConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "wbr"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # Word break opportunity - in markdown we just ignore the wbr element itself
      # but process any children (text that comes after it)
      # Markdown doesn't have a concept of line break suggestions
      # The text will naturally wrap where needed
      node.children.each { |child| Crhtml2markdown.convert_node(child, io) }
    end
  end
end
