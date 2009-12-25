module PhoneNumber::ActiveRecordExtensions
  def self.included( base )
    base.extend ActsMethods
  end

  module ActsMethods
    def phone_number( *args )
      unless included_modules.include? InstanceMethods
        self.class_eval { extend ClassMethods }
        include InstanceMethods
      end
      initialize_compositions( args )
    end

    alias_method :phone_numbers, :phone_number
  end

  module ClassMethods
    def initialize_compositions( attrs )
      attrs.each do |attr|
        composed_of attr, :class_name => 'PhoneNumber::Number', :mapping => ["raw_#{attr}", 'raw'], :converter => :convert,
                    :allow_nil => true
      end
    end
  end

  module InstanceMethods

  end
end