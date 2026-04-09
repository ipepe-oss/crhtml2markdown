module Crhtml2markdown
  class CodeConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "code" || node.name == "pre"
    end

    def convert(node : XML::Node, io : IO) : Nil
      if node.name == "pre"
        convert_block(node, io)
      else
        convert_inline(node, io)
      end
    end

    private def convert_block(node : XML::Node, io : IO)
      code_node = node.xpath_node(".//code") || node
      language = ""
      if klass = code_node["class"]?
        if klass.starts_with?("language-")
          language = klass.sub("language-", "")
        end
      end
      content = code_node.content
      io << "```" << language << "\n"
      io << content
      io << "\n" unless content.ends_with?("\n")
      io << "```\n\n"
    end

    private def convert_inline(node : XML::Node, io : IO)
      # Only handle inline code (not inside a <pre>)
      return if node.parent.try(&.name) == "pre"
      io << "`" << node.content << "`"
    end
  end
end
