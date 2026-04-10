module Crhtml2markdown
  class CodeConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "code" || node.name == "pre" || node.name == "var" || node.name == "samp"
    end

    def convert(node : XML::Node, io : IO) : Nil
      if node.name == "pre"
        convert_block(node, io)
      elsif node.name == "var" || node.name == "samp"
        convert_inline(node, io)
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
      fence = fence_for(content)
      io << fence << language << "\n"
      io << content
      io << "\n" unless content.ends_with?("\n")
      io << fence << "\n\n"
    end

    # Returns the shortest backtick fence that won't conflict with the content.
    # Per CommonMark spec, the fence must be longer than any backtick run in the content.
    private def fence_for(content : String) : String
      max_run = 0
      run = 0
      content.each_char do |c|
        if c == '`'
          run += 1
          max_run = run if run > max_run
        else
          run = 0
        end
      end
      "`" * {3, max_run + 1}.max
    end

    private def convert_inline(node : XML::Node, io : IO)
      # Only handle inline code (not inside a <pre>)
      return if node.parent.try(&.name) == "pre"
      content = node.content
      if content.includes?('`')
        io << "`` " << content << " ``"
      else
        io << "`" << content << "`"
      end
    end
  end
end
