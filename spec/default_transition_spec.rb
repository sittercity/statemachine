require File.dirname(__FILE__) + '/spec_helper'

context "Default Transition" do

  setup do
    @sm = Statemachine.build do
      trans :default_state, :start, :test_state
      
      state :test_state do
        default   :default_state
      end
    end
  end
  
  specify "the default transition is set" do
    test_state = @sm.get_state(:test_state)
    test_state.default_transition.should_not be(nil)
    test_state.transition_for(:fake_event).should_not be(nil)
  end
  
  specify "Should go to the default_state with any event" do
    @sm.start
    @sm.fake_event
    
    @sm.state.should eql(:default_state)
  end
  
  specify "default transition can have actions" do
    me = self
    @sm = Statemachine.build do
      trans :default_state, :start, :test_state
      
      state :test_state do
        default :default_state, :hi
      end
      context me
    end
    
    @sm.start
    @sm.blah
    
    @sm.state.should eql(:default_state)
    @hi.should eql(true)
  end
  
  def hi
    @hi = true
  end
  
  specify "superstate supports the default" do
    @sm = Statemachine.build do
      superstate :test_superstate do
        default :default_state
        
        state :start_state
        state :default_state
      end
      
      startstate :start_state
    end
    
    @sm.blah
    @sm.state.should eql(:default_state)
  end
  
  specify "superstate transitions do not go to the default state" do
    @sm = Statemachine.build do
      superstate :test_superstate do
        event :not_default, :not_default_state
        
        state :start_state do 
          default :default_state
        end
        
        state :default_state
      end
      
      startstate :start_state
    end
    
    @sm.state = :start_state
    @sm.not_default
    @sm.state.should eql(:not_default_state)
  end

  
end
