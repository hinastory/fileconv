require 'fileconv'

class ModifyNewLine
  include Fileconv::Line
  def input_ext
    "txt"
  end

  def init_conv
    @opts[:new_line] = "\r\n"
  end
end

ModifyNewLine.new.conv