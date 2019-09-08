require 'fileconv/base'

module Fileconv
  module Line
    include Fileconv::Base

    def pre_init_conv
      @opts[:line_mode] = true
    end

    def pre_convert_file(data, acc)
      unless @opts[:new_line]
        data =~ /\R/
        @opts[:new_line] = $1
        @opts[:new_line] ||= "\n"
      end

      data.split(/\R/)
    end

    def post_convert_file(data, acc)
      return data.join(@opts[:new_line]) if data
    end
  end
end