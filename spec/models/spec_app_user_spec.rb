require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../app'))

describe SpecAppUser do
  describe "attributes" do
    before do
      @attributes = SpecAppClag.spec_app_user_attributes
    end
    
    it "should have an email matching <random>@email.com" do
      @attributes[:email].should =~ /\w+\@email\.com/
    end
  end
  
  describe "new" do
    before do
      @user = SpecAppClag.new_spec_app_user
    end
    
    it "should be a SpecAppUser" do
      @user.class.should == SpecAppUser
    end
  
    it "should be a new record" do
      @user.should be_new_record
    end
    
    it "should have email matching <random>@email.com" do
      @user.email.should =~ /\w+\@email\.com/
    end
  end
end