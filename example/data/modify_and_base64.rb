require 'fileconv'
require 'base64'

class ModifyAndBase64
  include Fileconv::Data

  def input_ext
    "data"
  end

  def convert_file(data, acc)
    Base64.encode64(data + "modify")
  end
end

ModifyAndBase64.new.conv