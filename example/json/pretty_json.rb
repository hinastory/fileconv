require 'fileconv'

class PrettyJSON
  include Fileconv::JSON

  def input_ext
    "json"
  end
end

PrettyJSON.new.conv(pretty_json: true)