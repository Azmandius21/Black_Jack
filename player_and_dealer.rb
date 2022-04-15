require_relative 'game'
require_relative 'reset'
require_relative 'show_cards'

class Human
  include Reset
  include ShowCards

  STARTMONEY = 100

  attr_accessor :cash, :bid, :cards, :points
  attr_reader :name

  def initialize(name)
    @name = name
    @cash = STARTMONEY
    @cards = {}
    @points = 0
    @bid = 10
  end

  private
end
