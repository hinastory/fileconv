require 'fileconv'

class AddColumn
  include Fileconv::CSV
  def input_ext
    "csv"
  end

  def convert_line(line, acc)
    line.push "hoge"
  end
end

AddColumn.new.conv
