require 'fileconv'

class ReadBytes
  include Fileconv::File

  def input_ext
    "data"
  end

  def convert_file(file, acc)
    str  = ""
    while data = file.read(5) do
      str << data
      str << "\n"
    end
    str
  end
end

ReadBytes.new.conv