module Crhtml2markdown
  class HeadingConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      heading_level(node.name) != nil
    end

    def convert(node : XML::Node, io : IO) : Nil
      level = heading_level(node.name)
      return unless level

      text = node.content.strip
      io << "#" * level << " " << text << "\n\n"
    end

    private def heading_level(name : String) : Int32?
      case name
      when "h1" then 1
      when "h2" then 2
      when "h3" then 3
      when "h4" then 4
      when "h5" then 5
      when "h6" then 6
      else           nil
      end
    end
  end
end
