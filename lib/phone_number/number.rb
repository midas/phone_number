module PhoneNumber
  class Number
    attr_reader :country_code, :area_code, :subscriber_number_prefix, :subscriber_number_postfix, :extension

    def initialize( number )
      if number.is_a?( String ) && m = number.match( /^(\d{1,2})(\d{3})(\d{3})(\d{4})x?(\d*)$/ )
        @country_code, @area_code, @subscriber_number_prefix, @subscriber_number_postfix, @extension = m[1], m[2], m[3], m[4], m[5]
      elsif number.is_a?( Hash )
        @country_code, @area_code, @subscriber_number_prefix, @subscriber_number_postfix, @extension = number[:country_code], number[:area_code], number[:subscriber_number_prefix], number[:subscriber_number_postfix], number[:extension]
      end

      @@pattern_map = {
              /%c/ => (@country_code || '').gsub( /0/, '' ) || "",
              /%C/ => @country_code || "",
              /%a/ => @area_code || "",
              /%m/ => @subscriber_number_prefix || "",
              /%p/ => @subscriber_number_postfix || "",
              /%x/ => @extension || ""
      }

      @@patterns = {
              :us => "%c (%a) %m-%p x %x",
              :us_short => "(%a) %m-%p",
              :nanp_short => "(%a) %m-%p"
      }

      self.freeze
    end

    def self.parse( number )
      number.gsub!( / x /, 'x' )
      if m = number.match( /^\+?(\d{0,2})[ \.\-]?\(?(\d{3})\)?[ \.\-]?(\d{3})[ \.\-]?(\d{4})[ x]?(\d*)$/ )
        cntry_cd = m[1].size == 2 ? m[1] : "0#{m[1]}"
        cntry_cd = '01' if cntry_cd.nil? || cntry_cd.empty? || cntry_cd == '0'
        Number.new( :country_code => cntry_cd, :area_code => m[2], :subscriber_number_prefix => m[3], :subscriber_number_postfix => m[4],
                    :extension => m[5] )
      end
    end

    def empty?
      return (@country_code.nil? || @country_code.empty?) && (@area_code.nil? || @area_code.empty?) && (@subscriber_number_prefix.nil? || @subscriber_number_prefix.empty?) &&
              (@subscriber_number_postfix.nil? || @subscriber_number_postfix.empty?) && (@extension.nil? || @extension.empty?)
    end

    # Creates a phone number based on pattern provided.  Defaults to US (NANP) formatting (111) 111-1111.
    #
    # Symbols:
    #   %c - country code
    #   %a - area code
    #   %m - subscriber prefix
    #   %p - subscriber postfix
    #
    def to_s( pattern="" )
      return '' if self.empty?
      to_return = pattern.is_a?( Symbol ) ? @@patterns[pattern] : pattern
      to_return = @@patterns[:us_short] if to_return.empty?
      @@pattern_map.each { |pat, replacement| to_return = to_return.gsub( pat, replacement ) }
      to_return.strip
    end

    def self.convert( number )
      parse( number )
    end

    private

    def raw
      ext = (@extension.nil? || @extension.empty?) ? "" : "x#{@extension}"
      "#{@country_code}#{@area_code}#{@subscriber_number_prefix}#{@subscriber_number_postfix}#{ext}"
    end
  end
end