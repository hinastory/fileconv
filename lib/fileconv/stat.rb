require 'fileconv/base'

module Fileconv
  module Stat
    include Fileconv::Base

    def pre_init_conv
      @opts[:disable_read_file] = true
    end

    def pre_convert_file(data, acc)
      ::File.stat(acc[:orig_filename])
    end
  end
end