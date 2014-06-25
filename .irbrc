require 'rubygems'

require 'active_support/time'
require 'awesome_print'
require 'irb/completion'

IRB.conf[:AUTO_INDENT] = true

class Object
  def ml(*m)
    methods.grep(/(#{m.join("|")})/)
  end
end

begin
  # load wirble
  require 'wirble'

  # start wirble (with color)
  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Couldn't load Wirble: #{err}"
end

# awesome_print
unless IRB.version.include?('DietRB')
  IRB::Irb.class_eval do
    def output_value
      ap @context.last_value
    end
  end
else # MacRuby
  IRB.formatter = Class.new(IRB::Formatter) do
    def inspect_object(object)
      object.ai
    end
  end.new
end

# show SQL queries in the console
if ENV.include?('RAILS_ENV') && ENV['RAILS_ENV'] == 'development'
  require 'active_record'
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  ActiveRecord::Base.connection_pool.clear_reloadable_connections!
end
