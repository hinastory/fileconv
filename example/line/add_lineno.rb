require 'fileconv'

class AddLineno
  include Fileconv::Line
  def input_ext
    "txt"
  end

  def init_acc(acc)
    acc[:lineno] = 0
  end

  def convert_line(line, acc)
    acc[:lineno] += 1
    "#{acc[:lineno]}: #{line}"
  end
end

AddLineno.new.conv