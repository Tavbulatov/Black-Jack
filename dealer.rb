# frozen_string_literal: true

class Dealer < Player
  attr_reader :poits, :purse, :rand_cards

  def initialize(name = 'Dealer')
    super
  end
end
