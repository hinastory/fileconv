require 'fileconv'

class NumberFilter
  include Fileconv::Line
  def input_ext
    "txt"
  end

  def init_conv
    @meta[:total] = []
  end

  def init_acc(acc)
    acc[:number] = 0
    acc[:no_number] = 0
  end

  def convert_line(line, acc)
    if line =~ /^\d+$/
      acc[:number] += 1
      line
    else
      acc[:no_number] += 1
      nil
    end
  end

  def convert_file(data, acc)
    if @opts[:debug]
      p acc
    end
    @meta[:total].push [File.basename(acc[:orig_filename]), acc[:number], acc[:no_number]]
    data
  end

  def conv_result
    @meta[:total].map do |e|
      "filename: #{e[0]}, number: #{e[1]}, no number: #{e[2]}"
    end.join("\n")
  end
end

NumberFilter.new.conv(debug: true)