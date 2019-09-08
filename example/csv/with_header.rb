require 'fileconv'

class WithHeader
  include Fileconv::CSV

  def input_ext
    "txt"
  end

  def init_conv
    opts = @opts[:read_csv_opts]
    opts[:headers] = true
    opts[:return_headers] = true
    opts[:write_headers] = true
  end

  def convert_line(row, acc)
    unless row.header_row?
      row["Age"] = 20
    end

    row
  end
end

WithHeader.new.conv
