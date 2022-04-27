require_ralative 'controller'
require_ralative 'player'
require_ralative 'diller'

puts 'Введите имя'
name = gets.strip.capitalize

@controller = Controller.new(name)
@controller.start_game
