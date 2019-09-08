require 'fileconv/base'
require 'csv'

module Fileconv
  module CSV
    include Fileconv::Base

    def pre_init_conv
      @opts[:line_mode] = true
      @opts[:read_csv_opts] ||= {}
      @opts[:write_csv_opts] ||= {}
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
      ::CSV.generate("", @opts[:write_csv_opts]) do |csv|
        rows.each do |row|
          csv << row
        end
      end
    end
  end
end