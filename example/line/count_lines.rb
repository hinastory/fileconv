require 'fileconv'

class CountLine
  include Fileconv::Line
  def input_ext
    "txt"
  end

  def convert_file(data, acc)
    puts "#{File.basename acc[:orig_filename]}: #{data.size} lines"
  end
end

CountLine.new.conv