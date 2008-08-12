require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../app'))

describe 'SpecAppEvent' do
  describe "User attributes", :shared => true do
    it "should have a created user" do
      @attributes[:user].class.should == SpecAppUser
      @attributes[:user].should_not be_new_record
    end
  end
  
  describe 'User::Created' do
    describe 'attributes' do
      before { @attributes = SpecAppClag.spec_app_event.user.created_attributes }
      
      it_should_behave_like "User attributes"
    end
    
    describe "User::Created with valid attributes", :shared => true do
      it "should be a SpecAppEvent::User::Created" do
        @event.class.should == SpecAppEvent::User::Created
      end

      it "should have a created user" do
        @event.user.class.should == SpecAppUser
        @event.user.should_not be_new_record
      end
    end

    describe "new" do
      before { @event = SpecAppClag.spec_app_event.user.new_created }

      it { @event.should be_new_record }

      it_should_behave_like "User::Created with valid attributes"
    end

    describe "create" do
      before { @event = SpecAppClag.spec_app_event.user.create_created }

      it { @event.should_not be_new_record }

      it_should_behave_like "User::Created with valid attributes"
    end
  end
  
  describe 'User::Updated' do
    describe 'attributes' do
      before { @attributes = SpecAppClag.spec_app_event.user.updated_attributes }
      
      it_should_behave_like "User attributes"
    end
    
    describe "User::Updated with valid attributes", :shared => true do
      it "should be a SpecAppEvent::User::Updated" do
        @event.class.should == SpecAppEvent::User::Updated
      end

      it "should have a created user" do
        @event.user.class.should == SpecAppUser
        @event.user.should_not be_new_record
      end
    end

    describe "new" do
      before { @event = SpecAppClag.spec_app_event.user.new_updated }

      it { @event.should be_new_record }

      it_should_behave_like "User::Updated with valid attributes"
    end

    describe "create" do
      before { @event = SpecAppClag.spec_app_event.user.create_updated }

      it { @event.should_not be_new_record }

      it_should_behave_like "User::Updated with valid attributes"
    end
  end
end