$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'active_record'
require 'phone_number'
require 'spec'
require 'spec/autorun'

Spec::Runner.configure do |config|

end

ActiveRecord::Base.configurations = YAML::load( IO.read( File.dirname(__FILE__) + '/database.yml' ) )
ActiveRecord::Base.establish_connection( 'test' )

ActiveRecord::Schema.define :version => 1 do
  create_table "users", :force => true do |t|
    t.string   "name",       :limit => 50
    t.string   "raw_home_phone", :limit => 35
    t.string   "raw_mobile_phone", :limit => 35
  end
end

class User < ActiveRecord::Base
  phone_number :home_phone, :mobile_phone
end