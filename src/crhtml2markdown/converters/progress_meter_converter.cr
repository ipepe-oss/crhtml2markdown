module Crhtml2markdown
  class ProgressMeterConverter < ElementConverter
    def handles?(node : XML::Node) : Bool
      node.name == "progress" || node.name == "meter"
    end

    def convert(node : XML::Node, io : IO) : Nil
      # For progress and meter, try to get meaningful text
      value = node["value"]?
      max = node["max"]? || "1"
      min = node["min"]? || "0"

      # Check if there's content
      content = node.content.strip

      if !content.empty?
        # Use the provided content
        io << content
      elsif value
        # Show percentage based on value
        max_value = max.to_f
        if max_value == 0
          max_value = 1
        end

        if max_value == 1.0 || max == "100"
          percentage = (value.to_f / max_value * 100).to_i
          io << percentage << "%"
        else
          io << value << "/" << max
        end
      else
        # Indeterminate progress or no value
        io << "..."
      end
    end
  end
end
