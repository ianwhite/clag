require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../app'))

describe SpecAppEvent do
  describe "SpecAppEvent::User attributes", :shared => true do
    it "should have a created user" do
      @attributes[:user].class.should == SpecAppUser
      @attributes[:user].should_not be_new_record
    end
  end
  
  describe SpecAppEvent::UserCreated do
    describe 'attributes' do
      before { @attributes = SpecAppClag.spec_app_event.user_created_attributes }
      
      it_should_behave_like "SpecAppEvent::User attributes"
    end
    
    describe "SpecAppEvent::UserCreated with valid attributes", :shared => true do
      it "should be a SpecAppEvent::UserCreated" do
        @event.class.should == SpecAppEvent::UserCreated
      end

      it "should have a created user" do
        @event.user.class.should == SpecAppUser
        @event.user.should_not be_new_record
      end
    end

    describe "new" do
      before { @event = SpecAppClag.spec_app_event.new_user_created }

      it { @event.should be_new_record }

      it_should_behave_like "SpecAppEvent::UserCreated with valid attributes"
    end

    describe "create" do
      before { @event = SpecAppClag.spec_app_event.create_user_created }

      it { @event.should_not be_new_record }

      it_should_behave_like "SpecAppEvent::UserCreated with valid attributes"
    end
  end
  
  describe SpecAppEvent::UserUpdated do
    describe 'attributes' do
      before { @attributes = SpecAppClag.spec_app_event.user_updated_attributes }
      
      it_should_behave_like "SpecAppEvent::User attributes"
    end
    
    describe "SpecAppEvent::UserUpdated with valid attributes", :shared => true do
      it "should be a SpecAppEvent::UserUpdated" do
        @event.class.should == SpecAppEvent::UserUpdated
      end

      it "should have a created user" do
        @event.user.class.should == SpecAppUser
        @event.user.should_not be_new_record
      end
    end

    describe "new" do
      before { @event = SpecAppClag.spec_app_event.new_user_updated }

      it { @event.should be_new_record }

      it_should_behave_like "SpecAppEvent::UserUpdated with valid attributes"
    end

    describe "create" do
      before { @event = SpecAppClag.spec_app_event.create_user_updated }

      it { @event.should_not be_new_record }

      it_should_behave_like "SpecAppEvent::UserUpdated with valid attributes"
    end
  end
end