require 'fileconv'

class InputFiles
  include Fileconv::Line
  def input_ext
    "txt"
  end

  def input_files(files)
    ["test1.txt", "test3.txt"]
  end

  def convert_line(line, acc)
    line + "modify"
  end

  def output_filename(filename, acc)
    File.basename(filename, ".txt") + "_modified.txt"
  end
end

InputFiles.new.conv