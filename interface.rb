# frozen_string_literal: true

class Interface
  def initialize(name)
    @controller = Controller.new(name)
  end

  def start_game
    @controller.start_game

    loop do
      @controller.add_cards_player_and_dealer
    end
  end
end
