require_relative 'player_and_dealer'
require_relative 'reset'

class Game
  include Reset

  CARD_DECK = { "2^": 2, "2+": 2, "2<3": 2, "2<>": 2,
                "3^": 3, "3+": 3, "3<3": 3, "3<>": 3,
                "4^": 4, "4+": 4, "4<3": 4, "4<>": 4,
                "5^": 5, "5+": 5, "5<3": 5, "5<>": 5,
                "6^": 6, "6+": 6, "6<3": 6, "6<>": 6,
                "7^": 7, "7+": 7, "7<3": 7, "7<>": 7,
                "8^": 8, "8+": 8, "8<3": 8, "8<>": 8,
                "9^": 9, "9+": 9, "9<3": 9, "9<>": 9,
                "10^": 10, "10+": 10, "10<3": 10, "10<>": 10,
                "J^": 10, "J+": 10, "J<3": 10, "J<>": 10,
                "Q^": 10, "Q+": 10, "Q<3": 10, "Q<>": 10,
                "K^": 10, "K+": 10, "K<3": 10, "K<>": 10,
                "A^": 11, "A+": 11, "A<3": 11, "A<>": 11 }.freeze
  RISKY = 17
  CHOISE = /^(1|2|3){1}$/.freeze

  attr_accessor :player, :dealer, :card_deck, :bank, :show,
                :count_add, :count_pass, :count_open_cards

  def initialize
    setup_new_game
    @show = proc { |cards, owner| puts "#{owner} have cards : #{cards.keys}" }
  end

  def start_new_round
    reset_current_session!
    player.reset_points_and_cards!
    dealer.reset_points_and_cards!
  end

  def begining_game
    2.times { player.cards.merge!(give_card) }
    puts "#{player.name} take 2 cards:  #{player.cards.keys}"
    2.times { dealer.cards.merge!(give_card) }
    puts 'Dealer take 2 cards:  * * '
    bid
    choise
  end

  def choise
    options = { '1' => :pass, '2' => :add, '3' => :open_cards }
    puts "You have #{scoring(player)} points \n#{player.name}, what do you want to do?"
    begin
      puts 'Pass - 1'.rjust(40) if count_pass.zero?
      puts 'Take card - 2'.rjust(40) if count_add.zero?
      puts 'Open cards - 3'.rjust(40)
      response = gets.chomp
      raise 'You must select and put number' unless response =~ CHOISE

      send options[response]
    rescue RuntimeError => e
      puts e.message
      retry
    end
  end

  def results
    round_results
    if dealer.points == player.points
      dead_heat
    elsif dealer.points > 21
      player.points > 21 ? dead_heat : winner(player)
    elsif player.points > 21
      dealer.points > 21 ? dead_heat : winner(dealer)
    elsif player.points < dealer.points
      winner(dealer)
    else
      winner(player)
    end
  end

  def all_person_cash
    puts "#{player.name} cash : #{player.cash}"
    puts "Dealer cash : #{dealer.cash}"
  end

  private

  def setup_new_game
    @card_deck = {}
    @dealer = nil
    @player = nil
    reset_current_session!
  end

  def reset_current_session!
    @bank = 0
    @count_add = 0
    @count_pass = 0
    @count_open_cards = 0
    if card_deck.size < 6
      self.card_deck = {}
      create_card_deck
      puts '!!! New card deck !!!'
    end
  end

  def create_card_deck
    self.card_deck = CARD_DECK.dup
  end

  def give_card
    card_num = rand(card_deck.size) - 1
    cards = card_deck.to_a
    card = cards[card_num]
    # binding.pry
    card_deck.delete(card.first)
    Hash[card.first, card.last]
  end

  def bid
    player.cash -= player.bid
    dealer.cash -= dealer.bid
    self.bank = player.bid + dealer.bid
  end

  def add
    player.cards.merge!(give_card)
    self.count_add += 1
    player.show_cards(player.name)
  end

  def pass
    self.count_pass += 1
    dealer_choise unless dealer.cards.size > 2
  end

  def dealer_choise
    scoring(dealer)
    dealer_deck = dealer.cards.size
    dealer.cards.merge!(give_card) if dealer.points < RISKY
    puts 'Dealer taked 1 card' if dealer.cards.size > dealer_deck
  end

  def winner(human)
    puts "#{human.name} win"
    human.cash += bank
  end

  def dead_heat
    player.cash += bank / 2
    dealer.cash += bank / 2
    puts 'Dead heat'
  end

  def round_results
    dealer.points = scoring(dealer)
    player.points = scoring(player)
    open_cards if count_open_cards.zero?
    puts "#{player.name} - #{player.points} vs  #{dealer.points} - Dealer"
  end

  def scoring(human)
    human.points = human.cards.values.inject do |sum, point|
      sum += point
    end
    human.cards.each_key do |card|
      human.points -= 10 if card =~ (/A/) && (human.points > 21)
    end
    human.points
  end

  def open_cards
    self.count_add += 1 # refactoring!!!!
    self.count_pass += 1
    self.count_open_cards += 1
    dealer_choise unless dealer.cards.size > 2
    player.show_cards(player.name)
    dealer.show_cards('Dealer')
  end
end
