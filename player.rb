require_relative 'game'
require_relative 'reset'

class Player
  include Reset
  STARTMONEY = 100

  attr_accessor :cash, :bid, :cards, :points
  attr_reader :name

  def initialize(name)
    @name, @cash = name, STARTMONEY
    @cards = {}
    @points = 0
    @bid = 10
  end

  def show_cards
    puts "Players cards : #{cards.keys}"
  end

  def reset!
    self.cards = {}
    self.points = 0
  end

  private


end
