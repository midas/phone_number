require File.expand_path( File.dirname(__FILE__) + '/../spec_helper' )
require File.expand_path( File.dirname(__FILE__) + '/number_parsing_shared_spec' )


describe "PhoneNumber::Number" do
  it "should agree that the MATCH_REGEX is /^\+?(\d{0,2})[ \.\-]?\(?(\d{3})\)?[ \.\-]?(\d{3})[ \.\-]?(\d{4})[ x]?(\d*)$/" do
    PhoneNumber::Number::MATCH_REGEX.should == /^\+?(\d{0,2})[ \.\-]?\(?(\d{3})\)?[ \.\-]?(\d{3})[ \.\-]?(\d{4})[ x]?(\d*)$/
  end

  describe "when initializing from a raw string with an extension" do
    before :each do
      @instance = PhoneNumber::Number.new( '012345678901x111' )
    end

    it_should_behave_like "The phone number 1-234-567-8901 x 111"
  end

  describe "when initializing from a raw string without an extension" do
    before :each do
      @instance = PhoneNumber::Number.new( '012345678901' )
    end

    it_should_behave_like "The phone number 1-234-567-8901"
  end

  describe "when being set equal to a string if correctly parsing" do
    numbers = ['012345678901',
               '+012345678901',
               '12345678901',
               '2345678901',
               '01-234-567-8901',
               '01.234.567.8901',
               '01 234 567 8901',
               '+01-234-567-8901',
               '+01.234.567.8901',
               '+01 234 567 8901',
               '1-234-567-8901',
               '1.234.567.8901',
               '1 234 567 8901',
               '+1-234-567-8901',
               '+1.234.567.8901',
               '+1 234 567 8901',
               '1 (234) 567-8901',
               '(234) 567-8901',
               '1 (234) 567.8901',
               '(234) 567.8901',
               '(234) 567 8901',
               '(234) 5678901',
               '(234)5678901',
               '1(234)5678901',
               '01(234)5678901',
               '+1(234)5678901',
               '+01(234)5678901']

    numbers.each do |number|
      describe "when parsing '#{number}'" do
        before :each do
          @instance = PhoneNumber::Number.parse( number )
        end

        it_should_behave_like "The phone number 1-234-567-8901"
      end

      # describe "when initializing '#{number}'" do
      #   before :each do
      #     @instance = PhoneNumber::Number.new( number )
      #   end
      #
      #   it_should_behave_like "The phone number 1-234-567-8901"
      # end
    end

    numbers.map{ |n| n + 'x111' }.each do |number|
      describe "'#{number}'" do
        before :each do
          @instance = PhoneNumber::Number.parse( number )
        end

        it_should_behave_like "The phone number 1-234-567-8901 x 111"
      end
    end

    numbers.map{ |n| n + ' x 111' }.each do |number|
      describe "'#{number}'" do
        before :each do
          @instance = PhoneNumber::Number.parse( number )
        end

        it_should_behave_like "The phone number 1-234-567-8901 x 111"
      end
    end
  end

  describe "when formatting output" do
    before :each do
      @instance = PhoneNumber::Number.new( '012345678901x111' )
    end

    it "should format the number correctly with the pattern '%a-%m-%p'" do
      @instance.to_s( '%a-%m-%p' ).should eql( '234-567-8901' )
    end

    it "should format the number correctly with the pattern '%a.%m.%p x %x'" do
      @instance.to_s( '%a.%m.%p x %x' ).should eql( '234.567.8901 x 111' )
    end

    it "should define a format of us_short" do
      @instance.to_s( :us_short ).should eql( '(234) 567-8901' )
    end

    it "should use the us_short format for its default format" do
      @instance.to_s( :us_short ).should eql( @instance.to_s )
    end
  end

  it "should agree that a newly instantiated phone number is empty" do
    PhoneNumber::Number.new( nil ).empty?.should be_true
  end
end
