require_relative 'game'

class Dealer
  include Reset

  STARTMONEY = 100

  attr_accessor :cash, :bid, :cards, :points
  attr_reader :name

  def initialize
    @cash = STARTMONEY
    @cards = {}
    @points = 0
    @bid = 10
  end

  private


end
