# frozen_string_literal: true

require_relative 'controller'
require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require_relative 'interface'
# @controller = Controller.new 'as'
puts 'Введите имя'
name = gets.strip.capitalize
@interface = Interface.new(name)
@interface.start_game
