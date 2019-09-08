require 'fileconv/base'

module Fileconv
  module File
    include Fileconv::Base

    def pre_init_conv
      @opts[:disable_read_file] = true
    end

    def pre_convert_file(data, acc)
      acc[:opend_file] = ::File.open(acc[:orig_filename], @opts[:read_file_opts])
    end

    def post_convert_file(data, acc)
      acc[:opend_file].close
      data
    end
  end
end