class Coach
  attr_accessor :rounds_count

  def initialize
    self.rounds_count = 0
  end

  def average
  end

  def record_round
    self.rounds_count = self.rounds_count + 1
  end
end
