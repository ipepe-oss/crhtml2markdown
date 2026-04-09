module Crhtml2markdown
  INLINE_ELEMENTS = Set{"p", "a", "em", "strong", "code", "span", "td", "th", "h1", "h2", "h3", "h4", "h5", "h6"}

  class TextConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.text?
    end

    def convert(node : XML::Node, io : IO) : Nil
      text = node.content
      return if text.strip.empty? && !inline_context?(node)
      io << text unless text.strip.empty? && text.includes?("\n")
    end

    private def inline_context?(node : XML::Node) : Bool
      parent = node.parent
      return false unless parent
      INLINE_ELEMENTS.includes?(parent.name)
    end
  end
end
