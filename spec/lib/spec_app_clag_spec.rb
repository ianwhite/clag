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
  
  describe "new" do
    before do
      @clag = SpecAppClag.new
    end
    
    it "#unique_for(:thing, &block) should produce unique results" do
      results = []
      5.times do
        results << @clag.unique_for(:thing) { rand(5) }
      end
      results.sort.should == [0,1,2,3,4]
    end
    
    it "#unique_for(:other_thing) { 'this never changes' } should raise an error second time" do
      @clag.unique_for(:other_thing) { 'this never changes' }.should == 'this never changes'
      lambda do
        @clag.unique_for(:other_thing) { 'this never changes' }
      end.should raise_error
    end
  end
  
  describe "respond_to" do
    [:create_foo, :create_foo!, :new_foo, :foo_attributes, :spec_app_event].each do |method|
      it { SpecAppClag.should respond_to(method)}
    end
  end
  
  describe "method_missing" do
    it "#does_not_exist should be passed to super method_missing" do
      lambda { SpecAppClag.does_not_exist }.should raise_error(NoMethodError)
    end
  end
end