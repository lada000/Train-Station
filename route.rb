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