# frozen_string_literal: true

class Dealer < Player
  attr_reader :poits, :purse, :cards

  def initialize(name = 'ДИЛЛЕР')
    super
  end
end
