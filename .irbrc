require 'rubygems'
require 'irb/completion' 

IRB.conf[:AUTO_INDENT] = true 

begin
  # load wirble
  require 'wirble'

  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end
