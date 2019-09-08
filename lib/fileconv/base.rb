module Fileconv
  module MetaConvertor
    # Pre-hook for {Convertor#init_conv}
    def pre_init_conv
    end

    # Post-hook for {Convertor#init_conv}
    def post_init_conv
    end

    # Pre-hook for {Convertor#input_files}
    def pre_input_files(files)
      files
    end

    # Post-hook for {Convertor#input_files}
    def post_input_files(files)
      files
    end

    # Pre-hook for {Convertor#init_acc}
    def pre_init_acc(acc)
    end

    # Post-hook for {Convertor#init_acc}
    def post_init_acc(acc)
    end

    # Pre-hook for {Convertor#convert_file}
    def pre_convert_file(file, acc)
      file
    end

    # Pre-hook for {Convertor#convert_line}
    def pre_convert_line(line, acc)
      line
    end

    # Post-hook for {Convertor#convert_line}
    def post_convert_line(line, acc)
      line
    end

    # Pre-hook for {Convertor#convert_file}
    def post_convert_file(file, acc)
      file
    end

    # Pre-hook for {Convertor#conv_result}
    def pre_conv_result
    end

    # Post-hook for {Convertor#conv_result}
    def post_conv_result(result)
      result
    end
  end

  module Convertor
    # Input Directory
    # @return [String]
    def input_dir
      @opts[:input_dir] || "."
    end

    # File extention for input file
    # @return [String,nil]
    # @note target all files if this method return nil
    def input_ext
      @opts[:input_ext]
    end

    # Output Directory
    # @return [String]
    def output_dir
      @opts[:output_dir] || "output"
    end

    # Input files
    # @param [Array<string>] files input files
    # @return [Array<String>]
    # @note you can overwrite default input files
    def input_files(files)
      files
    end

    # Initialize the convertor
    # @return [void]
    def init_conv
    end

    # Init a accumlator
    # @param [Hash] acc the accumulator for this file
    # @return [void]
    def init_acc(acc)
    end

    # Read a file
    # @param [Hash] acc the accumulator for this file
    # @return [Object,nil]
    # @note use default reader if this method return nil
    def read_file(filename, acc)
    end

    # Convert a Line
    # @param [Object] line the line object
    # @param [Hash] acc the accumulator for this file
    # @return [Object, Array, nil] the converted line
    # @note add the line object add all lines if this method return Array and don't add it if this method return nil
    def convert_line(line, acc)
      line
    end

    # Convert a File
    # @param [Object] file the file object
    # @param [Hash] acc the accumulator for this file
    # @return [String, nil]
    # @note output the string to a file({#output_filename}) and don't create file if this method return nil
    def convert_file(file, acc)
      file
    end

    # File name for the output
    # @param [String] filename original base file name
    # @param [Hash] acc the accumulator for this file
    # @return [String] the output file name
    def output_filename(filename, acc)
      filename
    end

    # File name for the result
    # @return [String] the result file name
    def result_filename
      @opts[:result_file] || "result.txt"
    end

    # Conversion result
    # @return [String, nil] the result
    # @note output the string result to a file({#result_filename}) and don't create file if this method return nil(default)
    # @note you can create result data using @meta or anather instance variable you create
    def conv_result
    end
  end

  module Base
    include MetaConvertor
    include Convertor

    def process_file(filename)
      if FileTest.directory? filename
        return
      end

      acc = {orig_filename: filename}
      pre_init_acc(acc)
      init_acc(acc)
      post_init_acc(acc)

      raw = nil
      unless @opts[:disable_read_file]
        raw = read_file(filename, acc)
        raw = ::File.read(filename, @opts[:read_file_opts]) unless raw
      end

      converted_file = pre_convert_file(raw, acc)
      if @opts[:line_mode]
        # Line mode
        converted_file = process_line(converted_file, acc)
      end

      converted_file = convert_file(converted_file, acc)
      converted_file = post_convert_file(converted_file, acc)
      if converted_file
        out = output_filename(::File.basename(filename), acc)
        Dir.mkdir output_dir if !Dir.exists? output_dir
        ::File.write(::File.join(output_dir, out), converted_file, @opts[:read_file_opts])
      end
    end

    def process_line(raw_lines, acc)
      lines = []
      raw_lines.each do |line|
        converted_line = pre_convert_line(line, acc)
        converted_line = convert_line(converted_line, acc)
        converted_line = post_convert_line(converted_line, acc)
        lines.push *converted_line
      end
      lines
    end

    # Run file conversion
    def conv(**opts)
      @meta = {}
      @opts = opts
      @opts[:read_file_opts] ||= {}
      @opts[:write_file_opts] ||= {}

      pre_init_conv()
      init_conv()
      post_init_conv()

      glob = input_ext ?  "*." + input_ext : "*"
      files = Dir.glob(::File.join(input_dir, glob))
      files = pre_input_files(files)
      files = input_files(files)
      files = post_input_files(files)

      files.each do |filename|
        process_file(filename)
      end

      pre_conv_result
      result = conv_result
      post_result = post_conv_result(result)
      if post_result
        Dir.mkdir output_dir if !Dir.exists? output_dir
        ::File.write(::File.join(output_dir, result_filename), post_result, @opts[:write_file_opts])
      end
    end

    private :process_file, :process_line
  end
end