module InstanceCounter 
  def self.included(base)
    base.extend ClassMetods 
    base.include InstanceMetods 
  end
  
  module ClassMetods 
    attr_reader :instance_counter

    private

    def increment_instance_counter  
      @instance_counter ||= 0
      @instance_counter += 1
    end
  end 

  module InstanceMetods 

    private 

    def increment_instance_counter 
      self.class.send(:increment_instance_counter)
    end
  end
end