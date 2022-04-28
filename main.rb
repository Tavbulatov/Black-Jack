require_relative 'controller'
require_relative 'player'
require_relative 'dealer'

puts 'Введите имя'
name = gets.strip.capitalize

@controller = Controller.new(name)
@controller.start_game
