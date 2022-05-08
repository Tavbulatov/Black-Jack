# frozen_string_literal: true

class Dealer < Player
  attr_accessor :poits, :purse, :rand_cards

  def initialize(name = 'Dealer')
    super
  end
end
