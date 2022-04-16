require_relative 'game'
require_relative 'reset'
require_relative 'show_cards'

class Human
  include Reset
  include ShowCards

  STARTMONEY = 100.freeze

  attr_accessor :cash, :bid, :cards, :points
  attr_reader :name

  @@instances = []

  def initialize(name)
    @name = name
    @cash = STARTMONEY.dup
    @cards = {}
    @points = 0
    @bid = 100
    @@instances.push(self)
  end
  @@count_stop_game = nil

  def count_stop_game
    @@count_stop_game
  end

  def controler!
    if self.cash <= 0
      @@count_stop_game ||= 1
      puts "#{self.name} lost all cash and lose this game"
    end
  end
end
