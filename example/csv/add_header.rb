require 'fileconv'

class AddColumn
  include Fileconv::CSV
  def input_ext
    "csv"
  end

  def convert_file(data, acc)
    data.unshift ["No", "vehicle", "count"]
  end
end

AddColumn.new.conv
