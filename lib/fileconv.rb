require "fileconv/version"

module Fileconv
  autoload :Base, 'fileconv/base'
  autoload :Line, 'fileconv/line'
  autoload :CSV,  'fileconv/csv'
  autoload :Data, 'fileconv/data'
  autoload :File, 'fileconv/file'
  autoload :JSON, 'fileconv/json'
end
