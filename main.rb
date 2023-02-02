require './company_name.rb'
require './station.rb' 
require './train.rb' 
require './passenger_train.rb'
require './cargo_train.rb'
require './passenger_wagon.rb'
require './cargo_wagon.rb'
require './route.rb' 
require './wagon.rb'
require './instanse_counter.rb'

# '''train1 = Train.new(1, "passenger",[])
# train2 = Train.new(2, "cargo", [])

# wagon1 = PassengerWagon.new
# wagon2 = CargoWagon.new

# station1 = Station.new("Minsk", [])
# station2 = Station.new("Varsava", [])

# route = Route.new(station1, station2)
# train1.add_route(route) 

# station2.add_train(train1)
# station2.add_train(train2)

# train1.add_wagon(wagon1)
# train1.add_wagon(wagon2)
# train2.add_wagon(wagon1)
# train2.add_wagon(wagon2)'''

class Main
  attr_accessor :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def show_all_stations
    puts 'All stations:'
    stations.each_with_index { |station, index| puts "#{index + 1}. #{station.name}\n" }
  end
  
  def show_all_stations_with_trains
    puts 'All stations with trains:'
    stations.each_with_index do |station, index| 
      puts "#{index + 1}. #{station.name}"
      station.show_train_list
    end
  end

  def show_all_trains
    puts 'All trains:'
    trains.each_with_index { |train, index| puts "#{index + 1}. #{train.number}\n" }
  end

  def show_all_routes
    puts 'All routes:'
    routes.each_with_index { |route, index| puts "#{index + 1}. #{route}\n" }
  end

  def show_wagons(train)
    puts 'All wagons:'
    train.wagon_list.each_with_index { |wagon, index| puts "#{index + 1}. #{wagon}\n" }
  end

  def select_wagon(train)
    puts 'Select the wagon: '
    show_wagons(train)
    choice = gets.chomp.to_i
    choice.between?(1, train.wagon_list.size) ? train.wagon_list[choice - 1] : nil
  end

  def select_route
    puts 'Select the route'
    show_all_routes
    route_choice = gets.chomp.to_i
    route_choice.between?(1, routes.size)? routes[route_choice - 1] : nil
  end

  def select_station
    show_all_stations
    puts 'Choose a station number'
    choice = gets.chomp.to_i
    choice.between?(1, stations.size) ? stations[choice - 1] : nil
  end

  def select_train 
    puts 'Select train: '
    show_all_trains
    answer = gets.chomp.to_i
    answer.between?(1, trains.size) ? trains[answer - 1] : 'Incorrect number'
  end

  def create_station
    puts 'Puts station name'
    station_name = gets.chomp
    @stations << Station.new(station_name, [])
  end

  def create_train
    puts 'Enter train number'
    number = gets.chomp.to_i

    puts "Select train type:\n
    1 - Passenger\n
    2 - Cargo"
    type = gets.chomp.to_i

    if type == 1
      @trains << PassengerTrain.new(number, [])
      puts "You have created a passenger train with number - #{number}"
    elsif type == 2
      @trains << CargoTrain.new(number, [])
      puts "You have created a cargo train with number - #{number}"
    else
      'Invalid data'
    end
  end 

  def choise_what_to_do_with_roate 
    puts "Do you want to:\n
    1 - Create roate\n
    2 - Add or remove a station"
    answer = gets.chomp.to_i
    if answer == 1
      create_route
    elsif answer == 2
      delete_create_route 
    else
      'Incorrect number'
    end
  end

  def create_route
    if stations.size < 2
      puts 'You do not have at least 2 stations to create the route'
    else
      puts 'Enter the first station in the route:'
      first_station = select_station

      puts 'Enter the last station in the route:'
      last_station = select_station

      route = Route.new(first_station, last_station)
      puts "You route is - #{route.station_list.map(&:name)}"
      @routes << route 
    end
  end

  def delete_create_route 
    loop do
      puts "What do you want?\n
      1 - Add an intermediate station\n
      2 - Delete intermediate station\n
      3 - Nothing"
      answer = gets.chomp.to_i

      case answer 
      when 1
        route = select_route
        puts 'Puts intermediate station:'
        station = select_station
        route.add_station(station)
        puts "You route is - #{route.station_list.map(&:name)}"
      when 2
        route = select_route
        puts 'Puts intermediate station to delite: '
        station = select_station
        route.delite_station(station)
        puts "You route is - #{route.station_list.map(&:name)}"
      when 3
        break
      else
        puts 'Incorrect number'
      end
    end
  end

  def assign_route_to_a_train
    train = select_train 
    route = select_route
    if train.nil? || route.nil? 
      puts 'Invalid data'
    else 
      train.add_route(route)
    end 
  end

  def add_wagon_to_a_train 
    train = select_train
    if train.is_a?(String)
      puts train
    else
      puts 'Write the wagon number'
      number = gets.chomp.to_i 
      if number.is_a?(String)
        puts 'Enter only number'
      else 
        wagon = train.train_type == 'cargo' ? CargoWagon.new(number) : PassengerWagon.new(number)
        train.add_wagon(wagon)
      end
    end
  end 

  def delite_wagon_to_a_train 
    train = select_train
    wagon = select_wagon(train)
    if train.is_a?(String)
      puts train
    else
      puts 'Write the wagon number'
      if wagon.nil?
        puts 'Enter number'
      else
        train.delite_wagon(wagon)
      end
    end
  end

  def move_the_train
    train = select_train
    puts "Select an action:\n
    1 - return to the station back\n
    2 - go to the station forward"
    unswer = gets.chomp.to_i
    if unswer == 1
      train.move_backward_stations
    elsif unswer == 2
      train.move_next_station
    else
      'Invalid data'
    end
  end 

  def look_station_list
    show_all_stations
    puts "Want to see a list of trains at a particular station?\n
    1 - yes\n
    2 - no"
    unswer = gets.chomp.to_i
    if unswer == 1
      station = select_station
      station.show_train_list
    elsif unswer == 2
      puts 'Ok'
    else 
      puts 'Invalid data'
    end
  end

  def start
    loop do 
      puts "You can:\n
      1. Create stations\n
      2. Create trains\n
      3. Create route and manage stations in it (add, delete)\n
      4. Assign a route to a train\n
      5. Add wagons to the train\n
      6. Disconnect wagons from the train\n
      7. Move the train along the route forward and backward\n
      8. View station list and train list at station\n
      0. Exit\n
      What do you want to do(enter a number)?"
      user_choise = gets.chomp.to_i
      case user_choise 
      when 1
        create_station
      when 2
        create_train 
      when 3
        choise_what_to_do_with_roate 
      when 4
        assign_route_to_a_train
      when 5
        add_wagon_to_a_train 
      when 6
        delite_wagon_to_a_train 
      when 7
        move_the_train 
      when 8
        look_station_list 
      when 0
        puts 'Have a nice day!'
        break
      else 
        puts 'Incorrect number'    
      end
    end
  end  
end

puts "Hey! This is a railway abstraction program.\n
Let's start!"
Main.new.start