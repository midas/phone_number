require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "PhoneNumber" do
  describe "having ActiveRecord extensions" do
    before :each do

    end

    it "should respond to phone_number" do
      ActiveRecord::Base.respond_to?( :phone_number ).should be_true
    end

    it "should respond to phone_number" do
      ActiveRecord::Base.respond_to?( :phone_numbers ).should be_true
    end
  end

  describe "having models descending from ActiveRecord" do
    before(:each) do
      @user = User.new( :home_phone => '(234) 567-8901 x 111', :mobile_phone => '(111) 111-1111 x 111' )
      @user.save!
    end

    it "should respond to raw_{attribute_nam}" do
      @user.respond_to?( :raw_home_phone ).should be_true
    end

    it "should save the phone number in raw format" do
      @user.raw_home_phone.should eql( '012345678901x111' )
    end

    it "should have a composed of attribute of type PhoneNumber::Number" do
      @user.home_phone.is_a?( PhoneNumber::Number ).should be_true
    end

    it "should have the correct country code" do
      @user.home_phone.country_code.should eql( '01' )
    end

    it "should have the area country code" do
      @user.home_phone.area_code.should eql( '234' )
    end

    it "should have the subscriber number prefix code" do
      @user.home_phone.subscriber_number_prefix.should eql( '567' )
    end

    it "should have the subscriber number postfix code" do
      @user.home_phone.subscriber_number_postfix.should eql( '8901' )
    end

    it "should have the correct extension" do
      @user.home_phone.extension.should eql( '111' )
    end

    describe "having a second phone number attribute" do
      it "should respond to raw_{attribute_nam}" do
        @user.respond_to?( :raw_mobile_phone ).should be_true
      end

      it "should save the phone number in raw format" do
        @user.raw_mobile_phone.should eql( '011111111111x111' )
      end

      it "should have a composed of attribute of type PhoneNumber::Number" do
        @user.mobile_phone.is_a?( PhoneNumber::Number ).should be_true
      end

      it "should have the correct country code" do
        @user.mobile_phone.country_code.should eql( '01' )
      end

      it "should have the area country code" do
        @user.mobile_phone.area_code.should eql( '111' )
      end

      it "should have the subscriber number prefix code" do
        @user.mobile_phone.subscriber_number_prefix.should eql( '111' )
      end

      it "should have the subscriber number postfix code" do
        @user.mobile_phone.subscriber_number_postfix.should eql( '1111' )
      end

      it "should have the correct extension" do
        @user.mobile_phone.extension.should eql( '111' )
      end
    end
  end
end
