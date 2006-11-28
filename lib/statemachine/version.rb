module Statemachine
  module VERSION
    unless defined? MAJOR
      MAJOR  = 0
      MINOR  = 2
      TINY   = 2

      STRING = [MAJOR, MINOR, TINY].join('.')
      TAG    = "REL_" + [MAJOR, MINOR, TINY].join('_')

      NAME   = "Statemachine"
      URL    = "http://statemachine.rubyforge.org/"  
    
      DESCRIPTION = "#{NAME}-#{STRING} - Statemachine Library for Ruby\n#{URL}"
    end
  end
end