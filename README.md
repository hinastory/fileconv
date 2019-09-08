# Fileconv

Extensible multi-file convertor. Simple text file, CSV file, JSON file, binary file and so on.

`fileconv` gem is a simple to use and extensible library to convert multi-file format. You can extend your class with `MetaConvertor` and convert files into various format.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fileconv'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fileconv

## Usage

You have to do a few things to build a Convertor with `fileconv` gem.

- include `MetaConvertor`(e.g. `Fileconv::Line`) into your object,
- add some hooks(e.g. `input_ext`) if you need.

Lets start with a simple example. It will be a convertor for simple text files.

```ruby
require 'fileconv'

class AddLinenoConvertor
  include Fileconv::Line
  def input_ext
    "txt"
  end

  def init_acc(acc)
    acc[:lineno] = 0
  end

  def convert_line(line, acc)
    acc[:lineno] += 1
    "#{acc[:lineno]}: #{line}"
  end
end

```

That's it. Now you can use a method `#conv` to convert all text files(`.txt`) from into text files with line number.

```
convertor = AddLinenoConvertor.new
covertor.conv
```

If you have two text(`.txt`) files:

`aaa.txt`
```
aaa
bbb
ccc
```

`bbb.txt`
```
111
222
333
```

the convertor convert it into:

`output/aaa.txt`
```
1: aaa
2: bbb
3: ccc
```

`output/bbb.txt`
```
1: 111
2: 222
3: 333
```

### Convertor Hooks

You can overwrite convertor hooks if you need. The default action is that a converter copies all files in the current directory to an “output” directory. The convertor make the "output" directory in the current directory if it doesn't exist.

|hook|default|description|
|---|---|---|
|input_dir|"."(current directory)|input Directory|
|input_ext|`nil` (all files)|input extension|
|output_dir|"output"|output directory|
|input_files(files)|`files`|input files|
|init_conv|`nil`|init convertor hook|
|init_acc(acc)|`nil`|init accumulator hook|
|read_file(filename, acc)|`nil` (use default reader)|read file hook|
|convert_line(line, acc)|`line`|convert line hook|
|convert_file(file, acc)|`file`|convert file hook|
|output_filename(filename, acc)|`filename`|output filename|
|result_filename|"result.txt"|result filename|
|conv_result|`nil`|conversion result|

Input files is selected by `input_dir` and `input_ext`. you can overwrite it with `#input_files` hooks.

The most commonly used hooks are：

- `#input_ext`
- `#convert_line`
- `#convert_file`
- `#conv_result`

### Convertor Variables

You can use several convertor variables. Convertor variables are `Hash` type and have a specific scope. `acc` has single file scope, which means that it is initialized for each file. `@meta` and `@opts` is valid in a convertor. `@opts` variable is set by `#conv` method that takes user options. you can use `@meta` variable for any purpose.

|variable|scope|descripton|
|---|---|---|
|acc|file|accumulator for a file|
|@meta|convertor|meta data for the convertor|
|@opts|convertor|options for the convertor|

### Default MetaConvertors

`fileconv` gem have several default MetaConvertors. MetaConverters are mainly intended to be included by a converter.

|MetaConvertor|mode|description|
|---|---|---|
|Line|Line|raw line convertor|
|CSV|Line|CSV line convertor|
|Data|File|raw file data convertor|
|File|File|`File` convertor|
|JSON|File|JSON convertor|

Convertors(includes MetaConvertors) can be divided into two modes.

- Line Mode
  - `#convert_line` hooks is called.
  - e.g. `Line`, `CSV`
- File Mode
  - `#convert_line` hooks is not called.
  - e.g. `Data`, `File`, `JSON`

Let's see a JSON MetaConvertor usage.

```ruby
require 'fileconv'

class ModifyJSONConvertor
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

ModifyJSONConvertor.new.conv
```

original file (`address.json`) :
```json
[{"name": "Mike", "Age": "21"}, {"name": "Jon", "Age": "33"}]
```

converted file (`output/address.json`) :
```json
[{"name":"Mike","Age":"21","country":"USA"},{"name":"Jon","Age":"33","country":"USA"}]
```


### Make MetaConvertor

You can make meta convertor easily.
`fileconv` gem's JSON MetaConvertor is below:

```ruby
require "json"

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
```

MetaConvertors can use below hooks:

- pre_init_conv
- post_init_conv
- pre_input_files
- post_input_files
- pre_init_acc
- post_init_acc
- pre_convert_file
- pre_convert_line
- post_convert_line
- post_convert_file
- pre_conv_result
- post_conv_result

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hinastory/fileconv.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
