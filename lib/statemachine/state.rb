module Statemachine

  class State #:nodoc:
    
    attr_reader :id, :statemachine, :superstate
    attr_accessor :entry_action, :exit_action, :default_transition

    def initialize(id, superstate, state_machine)
      @id = id
      @superstate = superstate
      @statemachine = state_machine
      @transitions = {}
    end

    def add(transition)
      @transitions[transition.event] = transition
    end
  
    def transitions
      return @superstate ? @transitions.merge(@superstate.transitions) : @transitions
    end
    
    def transition_for(event)
      transition = @transitions[event]
      transition = @superstate.transition_for(event) if @superstate and not transition      
      transition = @default_transition if not transition
      return transition 
    end
    
    def exit(args)
      @statemachine.trace("\texiting #{self}")
      @statemachine.invoke_action(@exit_action, args, "exit action for #{self}") if @exit_action
      @superstate.substate_exiting(self) if @superstate
    end

    def enter(args=[])
      @statemachine.trace("\tentering #{self}")
      @statemachine.invoke_action(@entry_action, args, "entry action for #{self}") if @entry_action
    end
    
    def activate
      @statemachine.state = self
    end
    
    def is_concrete?
      return true
    end
    
    def reset
    end

    def to_s
      return "'#{id}' state"
    end

  end
  
end