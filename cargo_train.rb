require './train.rb'

class CargoTrain < Train 
    def initialize(number, wagon_list)
      super
      @train_type = 'cargo' 
    end
  end