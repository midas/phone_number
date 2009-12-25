$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require 'phone_number/number'
require 'phone_number/active_record_extensions'

module PhoneNumber
  VERSION = '1.0.0'
end

ActiveRecord::Base.send( :include, PhoneNumber::ActiveRecordExtensions ) if defined?( ActiveRecord::Base )