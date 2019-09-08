require 'fileconv/base'
require 'json'

module Fileconv
  module JSON
    include Fileconv::Base

    def pre_init_conv
      @opts[:read_json_opts] ||= {}
      @opts[:write_json_opts] ||= {}
    end

    def pre_convert_file(data, acc)
      ::JSON.parse(data, @opts[:read_json_opts])
    end

    def post_convert_file(obj, acc)
      return unless obj
      if @opts[:pretty_json]
        ::JSON.pretty_generate(obj, @opts[:write_json_opts])
      else
        ::JSON.generate(obj, @opts[:write_json_opts])
      end
    end
  end
end