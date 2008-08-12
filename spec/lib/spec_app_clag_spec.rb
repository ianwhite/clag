require File.expand_path(File.join(File.dirname(__FILE__), '../spec_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../app'))

describe "SpecAppClag" do
  it "should have namespace of []" do
    SpecAppClag.namespace.should == []
  end

  it ".spec_app_event should == SpecAppClag::SpecAppEvent" do
    SpecAppClag.spec_app_event.should == SpecAppClag::SpecAppEvent
  end
  
  describe "SpecAppEvent" do
    it "should have namespace of [:spec_app_event]" do
      SpecAppClag::SpecAppEvent.namespace.should == [:spec_app_event]
    end
    
    it ".user should == SpecAppClag::SpecAppEvent::User" do
      SpecAppClag::SpecAppEvent.user.should == SpecAppClag::SpecAppEvent::User
    end
    
    describe "User" do
      it "should have namespace of [:spec_app_event, :user]" do
        SpecAppClag::SpecAppEvent::User.namespace.should == [:spec_app_event, :user]
      end
    end
  end
end