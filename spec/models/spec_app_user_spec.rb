require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../app'))

describe SpecAppUser do
  describe "attributes" do
    before { @attributes = SpecAppClag.spec_app_user_attributes }
    
    it "should have an email matching <random>@email.com" do
      @attributes[:email].should =~ /\w+\@email\.com/
    end
  end
  
  describe "attributes :email => 'this@email.com'" do
    before { @attributes = SpecAppClag.spec_app_user_attributes :email => 'this@email.com'}
    
    it "should have an email == 'this@email.com'" do
      @attributes[:email].should == 'this@email.com'
    end
  end
  
  describe "SpecAppUser with valid attributes", :shared => true do
    it "should be a SpecAppUser" do
      @user.class.should == SpecAppUser
    end
    
    it "should have email matching <random>@email.com" do
      @user.email.should =~ /\w+\@email\.com/
    end
  end
  
  describe "new" do
    before { @user = SpecAppClag.new_spec_app_user }
    
    it { @user.should be_new_record }
    
    it_should_behave_like "SpecAppUser with valid attributes"
  end
  
  describe "new :email => 'this@email.com'" do
    before { @user = SpecAppClag.new_spec_app_user :email => 'this@email.com'}
    
    it "should have an email == 'this@email.com'" do
      @user.email.should == 'this@email.com'
    end
  end
  
  describe "create" do
    before do
      @user = SpecAppClag.create_spec_app_user
    end

    it { @user.should_not be_new_record }
    
    it_should_behave_like "SpecAppUser with valid attributes"
  end
end