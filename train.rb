class Train
  attr_accessor :speed, :train_type
  attr_reader :wagon_list, :current_station, :number

  def initialize(number, wagon_list)
    @number = number
    @wagon_list = wagon_list
    @speed = 0
  end

  def stop 
    @speed = 0
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

  def add_wagon(wagon)
    if speed.zero? 
      if train_type == wagon.type
        @wagon_list << wagon
      else
        "wagon type does not match train type. Train type is #{train_type}"
      end
    else 
      puts 'wagon speed should be equal to 0'
    end
  end 

  def delite_wagon(wagon)
    if speed.zero?
      @wagon_list.delete(wagon)
    else 
      puts 'wagon speed should be equal to 0'
    end
  end

  protected  

  def current_station_index
    @route.index_of_station(@current_station)
  end
end