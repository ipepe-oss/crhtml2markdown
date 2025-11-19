require "file_utils"

EXCLUDED_DIRS = ["migrations"]

src_files = [] of String
missing_specs = [] of String

Dir.glob("src/**/*.cr") do |file|
  relative_path = file.sub("src/", "")

  next if relative_path.count("/") == 0

  dir_name = relative_path.split("/").first
  next if EXCLUDED_DIRS.includes?(dir_name)

  src_files << file

  spec_path = file.sub("src/", "spec/").sub(".cr", "_spec.cr")

  unless File.exists?(spec_path)
    missing_specs << file
  end
end

puts "Test Coverage Report"
puts "=" * 50

if missing_specs.empty?
  puts "[OK] All source files have corresponding specs!"
  puts "  Total files checked: #{src_files.size}"
else
  puts "[FAIL] Missing spec files:"
  puts
  missing_specs.each do |file|
    spec_path = file.sub("src/", "spec/").sub(".cr", "_spec.cr")
    puts "  #{file}"
    puts "    -> Expected: #{spec_path}"
    puts
  end
  puts "Summary: #{missing_specs.size}/#{src_files.size} files missing specs"
  exit 1
end
