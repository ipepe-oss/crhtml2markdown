module Crhtml2markdown
  class ListConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "ul" || node.name == "ol"
    end

    def convert(node : XML::Node, io : IO) : Nil
      convert_list(node, io, 0)
      # Add trailing newline only for top-level lists
      unless node.parent.try(&.name) == "li"
        io << "\n"
      end
    end

    private def convert_list(node : XML::Node, io : IO, depth : Int32)
      ordered = node.name == "ol"
      index = if ordered && (start = node["start"]?)
                start.to_i? || 1
              else
                1
              end
      node.children.each do |child|
        next unless child.name == "li"
        indent = "    " * depth
        marker = ordered ? "#{index}." : "-"
        io << indent << marker << " "
        ends_with_sublist = convert_li_content(child, io, depth)
        io << "\n" unless ends_with_sublist
        index += 1
      end
    end

    private def convert_li_content(node : XML::Node, io : IO, depth : Int32) : Bool
      ends_with_sublist = false
      indent = "    " * (depth + 1)

      # Collect paragraphs and other block children
      paragraphs = [] of String
      buffer = IO::Memory.new
      has_sublists = false

      node.children.each do |child|
        if child.name == "ul" || child.name == "ol"
          # Flush buffer as a paragraph
          text = buffer.to_s.strip
          paragraphs << text unless text.empty?
          buffer.clear

          # Write paragraphs collected so far
          paragraphs.each_with_index do |para, i|
            if i == 0
              io << para
            else
              write_indented_block(io, para, indent)
            end
          end
          paragraphs.clear

          io << "\n"
          convert_list(child, io, depth + 1)
          ends_with_sublist = true
          has_sublists = true
        elsif child.name == "p" || child.name == "pre" || child.name == "blockquote"
          # Handle paragraphs and block-level elements that need indentation
          # Flush any non-paragraph buffer content first
          text = buffer.to_s.strip
          paragraphs << text unless text.empty?
          buffer.clear

          # For block elements like pre and blockquote, convert the whole element
          # to preserve formatting (newlines, indentation, etc.)
          block_text = if child.name == "p"
            # Paragraphs should be stripped
            String.build do |inner|
              child.children.each { |c| Crhtml2markdown.convert_node(c, inner) }
            end.strip
          else
            # Pre and blockquote need full formatting
            String.build do |inner|
              Crhtml2markdown.convert_node(child, inner)
            end.rstrip
          end

          paragraphs << block_text unless block_text.empty?
        else
          Crhtml2markdown.convert_node(child, buffer)
          unless child.text? && child.content.strip.empty?
            ends_with_sublist = false
          end
        end
      end

      # Flush remaining buffer
      text = buffer.to_s.strip
      paragraphs << text unless text.empty?

      # Write remaining paragraphs
      unless has_sublists && paragraphs.empty?
        paragraphs.each_with_index do |para, i|
          if i == 0
            io << para
          else
            write_indented_block(io, para, indent)
          end
        end
      end

      ends_with_sublist
    end

    # Write a block of text with all lines indented, separated by blank line
    private def write_indented_block(io : IO, text : String, indent : String) : Nil
      io << "\n\n"
      text.each_line(chomp: true) do |line|
        if line.empty?
          io << indent << "\n"
        else
          io << indent << line << "\n"
        end
      end
    end
  end
end
