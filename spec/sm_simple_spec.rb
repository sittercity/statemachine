require File.dirname(__FILE__) + '/spec_helper'

context "simple cases:" do
  setup do
    @sm = StateMachine::StateMachine.new
    @count = 0
    @proc = Proc.new {@count = @count + 1}
  end
  
  specify "one transition has states" do
    @sm.add(:on, :flip, :off, @proc)
    
    @sm.states.length.should_be 2
    @sm[:on].should_not_be nil
    @sm[:off].should_not_be nil
  end
    
  specify "one trasition create connects states with transition" do
    @sm.add(:on, :flip, :off, @proc)
    origin = @sm[:on]
    destination = @sm[:off]
    
    origin.transitions.length.should_be 1
    destination.transitions.length.should_be 0
    transition = origin[:flip]
    check_transition(transition, :on, :off, :flip, @proc)
  end

  specify "reset" do
    @sm.add(:start, :blah, :end, @proc)
    @sm.run
    @sm.process_event(:blah)
    
    @sm.reset
    
    @sm.state.should.be @sm[:start]
  end
  
  specify "exception when state machine is not running" do
    @sm.add(:on, :flip, :off)
    
    begin
      @sm.process_event(:flip)
    rescue StateMachine::StateMachineException => e
      e.message.should_equal "The state machine isn't in any state.  Did you forget to call run?"
    end
  end

  specify "no proc in transition" do
    @sm.add(:on, :flip, :off)
    @sm.run
    
    @sm.flip
  end

  specify "Can use state to add transitions instead of symbols" do
    @sm.add(:on, :toggle, :off)
    @sm.add(@sm[:off], :toggle, @sm[:on])
    @sm.run
    
    @sm.toggle
    @sm.toggle
    
    @sm.state.id.should_be :on
  end

  
  
end
