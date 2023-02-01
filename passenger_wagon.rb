require './wagon.rb'

class PassengerWagon < Wagon
    def initialize(number)
      super
      @type = 'passenger'
    end
  end 