module Crhtml2markdown
  class RubyConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "ruby"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # For ruby annotations, convert to parentheses format
      # e.g., 漢字 -> 漢(かん)字(じ)
      children = node.children.to_a

      i = 0
      while i < children.size
        child = children[i]

        if child.element? && child.name == "rb"
          # Base text
          io << child.content.strip

          # Look ahead for rt
          if i + 1 < children.size && children[i + 1].element? && children[i + 1].name == "rt"
            rt_content = children[i + 1].content.strip
            io << "(" << rt_content << ")"
            i += 1 # Skip the rt element
          end
        elsif child.text?
          # Handle any text nodes directly
          content = child.content.strip
          io << content if !content.empty?
        elsif child.element? && child.name == "rt"
          # Standalone rt without preceding rb
          io << "(" << child.content.strip << ")"
        end

        i += 1
      end
    end
  end
end
