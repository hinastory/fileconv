require 'fileconv'

class ModifyJSON
  include Fileconv::JSON

  def input_ext
    "json"
  end

  def convert_file(data, acc)
    data.map do |e|
      e["country"] = "USA"
      e
    end
  end
end

ModifyJSON.new.conv