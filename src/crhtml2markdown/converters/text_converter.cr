module Crhtml2markdown
  class TextConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.text?
    end

    def convert(node : XML::Node, io : IO) : Nil
      text = node.content
      io << text unless text.strip.empty?
    end
  end
end
