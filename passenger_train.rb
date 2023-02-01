require './train.rb'

class PassengerTrain < Train
    def initialize(number, wagon_list)
      super
      @train_type = 'passenger' 
    end
  end