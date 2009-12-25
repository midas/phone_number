require File.expand_path( File.dirname(__FILE__) + '/../spec_helper' )

shared_examples_for "The phone number 1-234-567-8901 x 111" do
  it "should agree that the country code is '01'" do
    @instance.country_code.should eql( '01' )
  end

  it "should agree that the area code is '234'" do
    @instance.area_code.should eql( '234' )
  end

  it "should agree that the subscriber number prefix is '567'" do
    @instance.subscriber_number_prefix.should eql( '567' )
  end

  it "should agree that the subscriber number postfix is '234'" do
    @instance.subscriber_number_postfix.should eql( '8901' )
  end

  it "should agree that the extension is '111'" do
    @instance.extension.should eql( '111' )
  end
end

shared_examples_for "The phone number 1-234-567-8901" do
  it "should agree that the country code is '01'" do
    @instance.country_code.should eql( '01' )
  end

  it "should agree that the area code is '234'" do
    @instance.area_code.should eql( '234' )
  end

  it "should agree that the subscriber number prefix is '567'" do
    @instance.subscriber_number_prefix.should eql( '567' )
  end

  it "should agree that the subscriber number postfix is '234'" do
    @instance.subscriber_number_postfix.should eql( '8901' )
  end

  it "should agree that the extension is ''" do
    @instance.extension.should eql( '' )
  end
end