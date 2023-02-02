class Station 
  include InstanceCounter 

  attr_accessor :name

  @@all_stations = []
  
  def self.all_stations 
    @@all_stations.each { |station| puts station.name }
  end

  def initialize(name, train_list)
    @name = name
    @train_list = Set.new(train_list)
    @@all_stations << self
    increment_instance_counter
  end

  def add_train(train)
    @train_list << train
  end

  def send_train(train)
    @train_list.delete(train)
  end

  def show_train_list
    puts "Train list:
    #{@train_list.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }}"
  end
  
  def show_train_list_by_type(train_type)
    puts "Trains with #{train_type} type:"
    @train_list.each { |train| puts train.number if train.type == train_type }
  end
end 