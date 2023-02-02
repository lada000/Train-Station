class Wagon
  include Company
  include InstanceCounter  

  attr_reader :type 

  def initialize(number)
    @number = number 
    increment_instance_counter
  end
end
