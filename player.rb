class playerr

  STARTMONEY = 100

  def initialize(name)
    @name, @cash = name, STARTMONEY
    @player_cards_now = []
    @player_have_points = 0
    @player_bid = 10
  end
end
