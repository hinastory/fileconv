require 'fileconv'
require 'csv'
require 'json'

module Fileconv
  module CSV2JSON
    include Fileconv::Base

    def pre_init_conv
      @opts[:line_mode] = true
      @opts[:read_csv_opts] ||= {}
      @opts[:write_csv_opts] ||= {}
      @opts[:read_csv_opts][:headers] = true
      @opts[:read_csv_opts][:write_headers] = true
    end

    def pre_convert_file(data, acc)
      ::CSV.parse(data, @opts[:read_csv_opts])
    end

    def post_convert_line(line, acc)
      return unless line

      if line.is_a? ::CSV::Row
        [line]
      elsif line[0].is_a? Array
        line
      else
        [line]
      end
    end

    def post_convert_file(rows, acc)
      return unless rows
      obj = rows.map{|e| e.to_hash}
      if @opts[:pretty_json]
        ::JSON.pretty_generate(obj, @opts[:write_json_opts])
      else
        ::JSON.generate(obj, @opts[:write_json_opts])
      end
    end
  end
end

class TestCSV2JSON
  include Fileconv::CSV2JSON

  def input_ext
    "csv"
  end
end

TestCSV2JSON.new.conv(pretty_json: true)