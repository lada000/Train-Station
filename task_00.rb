class Station 
  attr_accessor :name
  
  def initialize(name, train_list)
    @name = name
    @train_list = Set.new(train_list)
  end

  def add_train(train)
    @train_list << train
  end

  def send_train(train)
    @train_list.delete(train)
  end

  def show_train_list
    puts 'Train list:'
    @train_list.each_with_index { |train, index| puts "#{index + 1}. #{train.number}" }
  end
  
  def show_train_list_by_type(train_type)
    puts "Trains with #{train_type} type:"
    @train_list.each { |train| puts train.number if train.type == train_type }
  end
end 

class Route
  attr_accessor :station_list

  def initialize(first_station, last_station)
    @station_list = [first_station, last_station]
  end

  def add_station(intermediate_station)
    @station_list.insert(-2, intermediate_station)
  end

  def delite_station(intermediate_station)
    if [first_station, last_station].include?(intermediate_station)
      puts 'You cannot delete the first or last station' 
    else 
      @station_list.delete(intermediate_station)
    end
  end

  def show_station_list
    puts 'Station list:'
    station_list.each_with_index { |station, index| puts "#{index + 1}. #{station.name}" }
  end

  def first_station
    station_list.first
  end

  def last_station
    station_list.last
  end

  def station_by_index(index)
    station_list[index]
  end

  def index_of_station(station)
    station_list.index(station)
  end
end 

class Train
  attr_accessor :speed
  attr_reader :number_of_wagons, :type, :current_station, :number

  def initialize(number, type, number_of_wagons)
    @number = number
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def stop 
    @speed = 0
  end 

  def add_wagon
    if speed.zero?
      @number_of_wagons += 1 
    else 
      puts 'wagon speed should be equal to 0'
    end
  end 

  def delite_wagon 
    if speed.zero?
      @number_of_wagons -= 1 
    else 
      puts 'wagon speed should be equal to 0'
    end
  end

  def add_route(route)
    @route = route 
    @current_station = @route.first_station
    current_station.add_train(self)
  end

  def move_next_station
    if @route.nil? 
      puts 'puts add_route'
    else  
      possible_station = next_station 
      unless possible_station.nil?
        current_station.send_train(self)
        @current_station = possible_station
        current_station.add_train(self)   
      end
    end
  end

  def move_backward_stations
    if @route.nil? 
      puts 'puts add_route'
    else  
      possible_station = previous_station
      unless possible_station.nil?
        current_station.send_train(self)
        @current_station = possible_station
        current_station.add_train(self) 
      end
    end
  end

  def previous_station
    if current_station == @route.first_station
      puts "You are at the first station - #{@route.first_station.name}, it is not possible to go back"
      return nil 
    else
      puts "Station - #{@route.station_by_index(current_station_index - 1)}"
      return @route.station_by_index(current_station_index - 1)
    end 
  end

  def next_station 
    if current_station == @route.last_station
      puts "You are at the last station - #{@route.last_station.name}, moving forward is impossible"
      return nil 
    else
      puts "Station - #{@route.station_by_index(current_station_index + 1)}"
      return @route.station_by_index(current_station_index + 1)
    end
  end

  private 

  def current_station_index
    @route.index_of_station(@current_station)
  end
end

train1 = Train.new(1, 'pass', 10)
train2 = Train.new(2, 'wagn', 30)

station1 = Station.new('Minsk', [])
station2 = Station.new('Varsava', [])

route = Route.new(station1, station2)
train1.add_route(route) 

station2.add_train(train1)
station2.add_train(train2)


