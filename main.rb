# frozen_string_literal: true

require_relative 'bank'
require_relative 'game'
require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'dealer'
require_relative 'interface'

class Blackjack
  def initialize(name)
    @interface = Interface.new(name)
    @interface.start_game
  end
end

puts 'Как вас зовут?'
name = gets.strip.capitalize

@blackjack=Blackjack.new(name)
