require 'fileconv'

class UniqLine
  include Fileconv::Line
  def input_ext
    "txt"
  end

  def init_acc(acc)
    acc[:lines] = {}
    acc[:dup_num] = 0
  end

  def convert_line(line, acc)
    if acc[:lines][line]
      acc[:dup_num] += 1
    else
      acc[:lines][line] = true
      line
    end
  end

  def convert_file(data, acc)
    if @opts[:debug]
      puts "#{acc[:orig_filename]} dup num= #{acc[:dup_num]}"
    end

    data
  end
end

UniqLine.new.conv(debug: true)