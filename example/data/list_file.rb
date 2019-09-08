require 'fileconv'

class ListFile
  include Fileconv::Data

  def init_conv
    @meta[:files] = []
    @opts[:disable_read_file] = true
  end

  def convert_file(data, acc)
    stat = File.stat(acc[:orig_filename])
    @meta[:files].push [File.basename(acc[:orig_filename]), stat.size, stat.mtime]
    nil
  end

  def conv_result
    total_size = @meta[:files].reduce(0){|sum, e| sum + e[1]}
    str = @meta[:files].map{|e| "#{e[0]}: size=#{e[1]}, modified time=#{e[2]}"}.join("\n")
    str << "\ntotal size: #{total_size} bytes"
  end
end

ListFile.new.conv