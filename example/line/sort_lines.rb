require 'fileconv'

class SortLines
  include Fileconv::Line
  def input_ext
    "txt"
  end

  def convert_file(data, acc)
    if @opts[:debug]
      p acc
    end
    data.sort
  end
end

SortLines.new.conv(debug: true)