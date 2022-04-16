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
    @bid = 10
    @@instances.push(self)
  end
  @@count_stop_game = nil

  def do_controler
    comtroler!()
  end

  private

  def controler!(instance)
    @@instances.each do |instance|
      @@count_stop_game ||= 1  if instance.cash.zero? || instance.cash < 0
    end
  end
end
